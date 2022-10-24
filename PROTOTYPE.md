This file is for prototyping the public facing API for this library. This is in progress and may change. This contains prototypes for [flutter_shu_epub](https://github.com/getBoolean/shu_epub/issues/19), but is temporarily kept here since development has not started on the Flutter widgets.

# shu_epub

## What Package To Install

Follow the [package install instructions](https://pub.dev/packages/shu_epub/install),
and you can start using shu_epub in your app:

```dart
// !!! Do not do this in the build method.
final controller = EpubController(bytes);
final controllerFromData = EpubController.fromData(bytes);
final controllerFromFile = await EpubController.fromFile(file);

// Go to CFI location
String epubCfiString = "book.epub#epubcfi(/6/4[chap01ref]!/4[body01]/10[para05]/3:10)";
EpubLocation epubLocation = EpubLocation(epubCfiString);
// go to new location
EpubGoResult goResult = controller.goTo(epubLocation);
// go back
EpubGoResult goResult = controller.goToPriorLocation();
// go to `epubLocation` again
EpubGoResult goResult = controller.goToForwardLocation();

// Previous location after tapping on EPUB CFI link
EpubLocation? priorLocation = controller.getPriorLocation();
// Previous location after going back to prior EpubLocation
EpubLocation? priorLocation = controller.getForwardLocation();
```

## Implementation

```dart
class EpubController extends ChangeNotifier {
	// TODO: Parse bytes into epub object
	final List<int> bytes;
	/// null if the book has not been opened
	EpubLocation? currentLocation;
	// `EpubLocationList` is a list with utility methods that are specific to `EpubLocation`. It acts similar to a stack
	EpubLocationList priorLocations = [];
	EpubLocationList forwardLocations = [];
	EpubReadingProgress readingProgress = EpubReadingProgress();
	
	EpubController(this.bytes, {EpubLocation? initialLocation})
		: currentLocation = initialLocation;
	EpubController.fromData(this.bytes, {EpubLocation? initialLocation})
		: currentLocation = initialLocation;;
	static EpubController fromFile(File file, {EpubLocation? initialLocation}) async {
		final bytes = await file.readAsBytes()
		// plus error handling for io exceptions (e.g., no such file or no permission)
		return EpubController(bytes, initialLocation: initialLocation);
	}
	EpubLocation getPriorLocation();
	EpubLocation getForwardLocation();

	// The app should retrieve the reading progress once the book is closed and save it
	EpubReadingProgress getReadingProgress() {
		returns readingProgress;
	}

	
	EpubGoResult goToPriorLocation() {
		// push `currentLocation` to `forwardLocations`
		// pop top item from `priorLocations`
		// update `currentLocation` with above result and notify listeners
		// `EpubView` animates to the new page
	}
	EpubGoResult goToForwardLocation() {
		// push `currentLocation` to `priorLocations`
		// pop top item from `forwardLocations`
		// update `currentLocation` with above result and notify listeners
		// `EpubView` animates to the new page
	}
	EpubGoResult goTo(EpubLocation) {
		// push `currentLocation` to `priorLocations`
		// update `currentLocation` and notify listeners
		// `EpubView` animates to the new page
	}

	// TODO: not sure about how to implement these two methods
	void goToPreviousPage();
	void goToNextPage() {
		// update `currentLocation` to ...
		// clear `forwardLocations` and notify listeners
		// `EpubView` animates to the new page
	}
}

class EpubReadingProgress {
	final EpubLocation location;
	final int percent;
	// ...
}

class EpubLocationList extends List<EpubLocation> {
	EpubLocation peek() => this[this.length - 1];
	void push(EpubLocation);
	EpubLocationList popFrom(EpubLocation);
	EpubLocation pop();
}

class EpubLocation {
	// TODO: https://idpf.org/epub/linking/cfi/epub-cfi.html
	final String rawCfi;
	// ...
}

class EpubGoResult {
	final EpubGoResultType type;
	final EpubLocation previousLocation;
	final EpubLocation newLocation;
	// ...
}

enum EpubGoResultType {
	success,
	noSuchLocation,
	invalidLocationFormat,
}
```

# flutter_shu_epub

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
	onTap: (String locationName, EpubLocation location) {
		print("Jumping to '$locationName' at location '$location'");
	},
	// Optional, default widget is provided
	itemBuilder: (String locationName, EpubLocation location, int percent) {
		return Text(locationName);
	},
	shrinkWrap: false,
);
```

\*`EpubCfi` stands for `Epub Canonical Fragment Identifiers`, see the [specifications](https://idpf.org/epub/linking/cfi/epub-cfi.html) for more details. TLDR, it is the link format used by EPUBs.

### Epub Go History

Use this widget to access the jump history of an `EpubController`. The widget will be rebuilt when the jump history changes. 

The history is kept in two stacks, one for previous locations and one for forward locations. When a jump is made the previous location CFI is added to the previous locations stack. If the user jumps back the previous location, it is moved to the forward locations stack. The forward locations stack is cleared on page scroll.

#### Usage

```dart
EpubGoHistory(
	controller: controller,
	// Each `EpubLocation` has the time the jump was made
	builder: (EpubLocation? priorLocation, EpubLocation? forwardLocation) {
		return Container(); // This could be a row with two buttons that call `controller.goTo(priorLocation)` when pressed. The controller is able to determine if it is at the top of one of the stacks and rebuilds with the new prior and forward locations
	}
);

// By default, only the top of the previous and forward location stack is given. Use `EpubGoHistory.all` to access a copy of the jump history stacks in the builder
EpubGoHistory.all(
	controller: controller,
	builder: (List<EpubLocation> priorLocations, List<EpubLocation> forwardLocations) {
		// If the user jumps to a prior location that is not the most recent, it and all more recent prior jumps will be moved to the forward jumps stack with the selected prior jump at the top of the stack.
		// The reverse is also true for the forward jumps stack.
		return Container();
	}
);
```

### EpubView

**Note:** The implementation of this is still in the experimental stages. Any help would be greatly appreciated. We need to somehow determine how much html text can fit on a page, and where the html for an arbitrary page starts and ends.

Ideally, I would like to be able to render the html natively in Flutter, but it needs to be done in a way that can determine the height of the widget before layout. Current Flutter Html packages do not support getting the height before layout. Another option is to render the html in a webview, but this greatly complicates making `flutter_shu_epub` a cross platform library.

As of now, it seems the best option is to create a custom Flutter html package which allows viewing the height before layout, using `TextPainter`, with `getPositionForOffset`. It should only support the most common html formatting such as bold and italics.

#### Usage

```dart
EpubView.paged(
	controller: controller,
	// TODO: what should be provided here for the html?
	// `builder` is called for every page in the `PageView.builder`.
	itemBuilder: (Widget html, EpubLocation? prior, EpubLocation? forward) {},
	onPageChanged: (EpubLocation previous, EpubLocation current) {},
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
	onScroll: (EpubLocation previous, EpubLocation current) {},
	// TODO: Determine fields
	// TODO: what should be provided here for the html?
	builder: (Widget html, EpubLocation? prior, EpubLocation? forward) {},
)
```

## Implementation

```dart
class EpubTableOfContents extends StatelessWidget {
	const EpubTableOfContents({
		this.controller,
		this.itemBuilder,
		this.onTap;
		// ...
	}) : this.currentChapter = currentChapter.getChapter();
	final EpubController controller;
	final Function(String locationName, EpubLocation location, int percent)? itemBuilder;
	final Function(String locationName, EpubLocation location)? onTap;
	// ...

	Widget build(BuildContext context) {
		// Scroll to item before controller.getCurrentLocation() if not null
		return ListView.builder(/** items **/);
	}
}
```