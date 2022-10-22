This file is for prototyping the public facing API for this library. This is in progress and may change. This contains prototypes for [flutter_shu_epub](https://github.com/getBoolean/shu_epub/issues/19), but is temporarily kept here since development has not started on the Flutter widgets.

## Getting Started

### Usage

```dart
// !!! Do not do this in the build method.
final controller = EpubController(bytes);
final controller = EpubController.fromData(bytes);
final controller = await EpubController.fromFile(file);
final controller = EpubController(bytes);
```

### Implementation

```dart
class EpubController extends ChangeNotifier {
	// TODO: Parse bytes into epub object
	final List<int> bytes;
	EpubCfi? currentLocation;
	// `EpubJumpList` is a list with utility methods that are specific to `EpubJump`. It acts similar to a stack
	EpubJumpList previousJumps = [];
	EpubJumpList forwardJumps = [];
	EpubReadingProgress readingProgress = EpubReadingProgress();
	
	EpubController(this.bytes, {EpubCfi? initialLocation})
		: currentLocation = initialLocation;
	EpubController.fromData(this.bytes, {EpubCfi? initialLocation})
		: currentLocation = initialLocation;;
	static EpubController fromFile(io.File file, {EpubCfi? initialLocation}) async {
		final bytes = await file.readAsBytes()
		// plus error handling for io exceptions (e.g., no such file or no permission)
		return EpubController(bytes, initialLocation: initialLocation);
	}

	// Returns null if the book has not been opened
	EpubCfi? getCurrentLocation() {
		return currentLocation;
	}

	// The app should retrieve the reading progress once the book is closed and save it
	EpubReadingProgress getReadingProgress() {
		returns readingProgress;
	}

	void jumpTo(EpubCfi) {
		// add to jump history
		// update `currentLocation` and notify listeners
	}

	void goToNextPage() {
		// update `currentLocation` and notify listeners
	}
}

class EpubReadingProgress {
	final EpubCfi location;
	final int percent;
	// ...
}

class EpubJump {
	final EpubCfi location;
	final DateTime time;
	// ...
}

class EpubJumpList extends List<EpubJump> {
	EpubJump peek() => this[this.length - 1];
	void push(EpubJump);
	EpubJumpList popFrom(EpubJump);
	EpubJump pop();
}

class EpubCfi {
	// TODO: https://idpf.org/epub/linking/cfi/epub-cfi.html
}
```

## Widgets

### Table of Contents

Displays the table of contents in a scrollable list. It will automatically scroll to the current chapter if it is provided.

#### Usage

```dart
EpubTableOfContents(
	// Required
	controller: controller,
	// Optional
	physics: null,
	// * Optional
	onJump: (String chapterName, EpubCfi cfi) {
		print("Jumping to '$chapterName' with cfi '$cfi'");
	},
	// Optional, jumps to this chapter in the list
	currentChapterCfi: EpubCfi.fromString(currentChapterCfi),
	// Optional, default widget is provided
	builder: (String chapterName, EpubCfi cfi, int percent) {
		return Text(chapterName);
	},
	shrinkWrap: false,
);
```

\*`EpubCfi` stands for `Epub Canonical Fragment Identifiers`, see the [specifications](https://idpf.org/epub/linking/cfi/epub-cfi.html) for more details. TLDR, it is the link format used by EPUBs.

### Jump History

Use this widget to access the jump history of an `EpubController`. The widget will be rebuilt when the jump history changes. 

The history is kept in two stacks, one for previous locations and one for forward locations. When a jump is made the previous location CFI is added to the previous locations stack. If the user jumps back the previous location, it is moved to the forward locations stack. The forward locations stack is cleared on page scroll.

#### Usage

```dart
EpubJumpHistory(
	controller: controller,
	// Each `EpubJump` has keeps the time the jump was made
	builder: (EpubJump? previousJump, EpubJump? forwardJump) {
		return Container(); // This could be a row with two buttons that call `controller.jumpTo(jump)` when pressed. The controller is able to determine if it is in the stack using the time of the jump.
	}
);

// By default, only the top of the previous and forward location stack is given. Use `EpubJumpHistory.all` to access a copy of the jump history stacks in the builder
EpubJumpHistory.all(
	controller: controller,
	builder: (List<EpubJump> previousJumps, List<EpubJump> forwardJumps) {
		// If the user jumps to a previous location that is not the most recent, it and all more recent previous jumps will be moved to the forward jumps stack with the selected previous jump at the top of the stack.
		// The reverse is also true for the forward jumps stack.
		return Container();
	}
);
```

### EpubView

**Note:** The implementation of this is still in the experimental stages. Any help would be greatly appreciated. We need to somehow determine how much html text can fit on a page, and where the html for an arbitrary page starts and ends.

#### Usage

```dart
EpubView.paged(
	controller: controller,
	// TODO: what should be provided here for the html?
	// `builder` is called for every page in the `PageView.builder`.
	builder: (Widget html, EpubJump? previousJump, EpubJump? forwardJump) {},
	onPageChanged: (EpubCfi previousCfi, EpubCfi currentCfi) {},
	reverse: false,
	physics: null,
	dragStartBehavior: null,
	allowImplicitScrolling: false,
	clipBehavior: null,
	scrollBehavior: null,
	padEnds: true,
)

EpubView.scrollable(
	controller: controller,
	physics: null,
	// `currentCfi` is the line at the top of the visible screen
	onScroll: (EpubCfi previousCfi, EpubCfi currentCfi) {},
	// TODO: Determine fields
)
```

#### Implementation

I am still currently exploring how to implement this. Ideally, I would like to be able to render the html natively in Flutter, but it needs to be done in a way that can determine the height of the widget before layout. Current Flutter Html packages do not support getting the height before layout. Another option is to render the html in a webview, but this greatly complicates making `flutter_shu_epub` a cross platform library.

As of now, it seems the best option is to create a custom Flutter html package which allows viewing the height before layout, using `TextPainter`, with `getPositionForOffset`. It should only support the most common html formatting such as bold and italics.