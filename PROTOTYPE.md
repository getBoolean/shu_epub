# Prototype API

Status: In progress

This is for prototyping the public facing API of this library, it is in progress and may change at any time. This also contains prototypes for [flutter_shu_epub](https://github.com/getBoolean/shu_epub/issues/19), but is temporarily kept here since development has not started on the Flutter widgets.

- [[#What Package To Install|What Package To Install]]
- [[#shu_epub|shu_epub]]
  - [[#shu_epub#ShuEpub Usage|ShuEpub Usage]]
  - [[#shu_epub#ShuEpub Implementation|ShuEpub Implementation]]
- [[#flutter_shu_epub|flutter_shu_epub]]
  - [[#flutter_shu_epub#Getting Started|Getting Started]]
  - [[#flutter_shu_epub#Widgets|Widgets]]
    - [[#Widgets#Table of Contents|Table of Contents]]
    - [[#Widgets#Epub Go History|Epub Go History]]
    - [[#Widgets#EpubView|EpubView]]
  - [[#flutter_shu_epub#Implementation|Implementation]]
    - [[#Implementation#Widget Implementation|Widget Implementation]]
    - [[#Implementation#Objects|Objects]]
- [[#shu_core|shu_core]]
- [[#flutter_shu_reader|flutter_shu_reader]]

## What Package To Install

- Flutter: [flutter_shu_epub](https://pub.dev/packages/flutter_shu_epub)
- Dart only (No Flutter): [shu_epub](https://pub.dev/packages/shu_epub)

## shu_epub

This Dart-only package provides an API for parsing EPUB files and extracting information from them. This is used by [flutter_shu_epub](https://pub.dev/packages/flutter_shu_epub), and could also be used by a shell/console only EPUB reader if someone was interested in implementing it.

### ShuEpub Usage

```dart
// TODO:
//   1. Parsing of Epub CFIs
//   2. Friendly API for extracting relavent information
//   3. Determine reading progress from Epub CFI
import 'package:universal_io/io.dart' as io;
import 'package:image/image.dart' as img;

Future<void> main() async {
    // Get a reference to the file (or the file bytes on web)
    final file = io.File("path/to/file.epub");
    // This line is for demonstration only, use a file picker or network request on web
    final bytes = await file.readAsBytes();

    EpubParserControllerArchiveIO controller = EpubParserController.file(file);
    
    // For Flutter and server applications, with direct file access to reduce memory usage.
    //
    // Not available on web.
    Epub epub = await Epub.fromFile(file);

    // Recommended only for web, or when direct file access is not available.
    // 
    // The user could delete the file after opening it in the application, so either:
    //   1. copy the file into the app directory and use [Epub.fromFile]
    //   2. load the file bytes and use [Epub.fromBytes]
    Epub _ = await Epub.fromBytes(bytes);
    
    // Opening an extracted epub. This works since epubs are actually just zip files
    //
    // Not available on web
    final directory = io.Directory("path/to/folder.epub/");
    Epub __ = await Epub.fromExtracted(directory);

    // Allows a custom implementation of `EpubParserController`
    Epub ___ = await Epub.fromCustom(controller);
    
    String title = epub.title;
    String description = epub.description;
    List<EpubAuthor> authors = epub.authors;
    img.Image image = await epub.coverImage;
    
    EpubTableOfContents toc = epub.tableOfContents;
    EpubReadingOrder readingOrder = epub.readingOrder;
    List<EpubImageFile> images = epub.images;
    List<EpubCssFile> cssFiles = epub.cssFiles;

    readingOrder.forEach((EpubFile file) {
        io.ContentType type = file.type;
        String content = await file.readAsString();
    });
}
```

### ShuEpub Implementation

```dart
import 'package:universal_io/io.dart' as io;
import 'package:image/image.dart' as img;

class Epub {
    final EpubParser parser;
    final EpubSchema schema; // instead of `EpubDetails`

    const Epub._({this.parser, this.schema})
    
    static Future<Epub> fromCustom<T extends EpubParserController>(T controller) async {
        final parser = EpubParser(controller: controller);
        final schema = await parser.readSchema();
        return Epub._(parser: parser, schema: schema);
    }

    static Future<Epub> fromBytes(List<int> bytes) {
        EpubParserControllerArchive controller = EpubParserController.bytes(
            bytes);
        return fromCustom(controller: controller)
    }
    
    static Future<Epub> fromFile(io.File file) {
        EpubParserControllerArchiveIO controller = EpubParserController.file(
            file);
        return fromCustom(controller: controller)
    }
    
    static Future<Epub> fromExtracted(io.Directory directory) {
        EpubParserControllerExtracted controller = EpubParserController.extracted(
            directory);
        return fromCustom(controller: controller)
    }

    String get title;
    /// Allows HTML formatting
    String get description;
    List<EpubAuthor> get authors;
    /// Uses the first image bigger than the min size if no cover image exists
    Future<img.Image?> get coverImage;
    EpubReadingOrder get readingOrder;
    EpubTableOfContents get tableOfContents;
    List<EpubImageFile> get images;
    List<EpubCssFile> get cssFiles;
    
    // ...
}

class EpubParser<T extends EpubParserController> {
    /// Provides ability to override how the files are retrieved. 
    final T controller;
    
    const EpubParser({required this.controller});

    /// Depending on `controller`, this will either only read into memory the files it needs, or read the entire `.epub` file into memory (stored in `controller`)
    Future<EpubSchema> readSchema();
    
    // ...
}

abstract EpubParserController {
    Future<List<int>?> getFileAsBytes(EpubPath path);
    
    Future<List<EpubPath>> get filePaths;
    // ...
}

/// Contains utilities for normalizing paths
class EpubPath {
    /// Relative to the epub root.
    ///
    /// Some paths defined in epubs are not relative to the root, their full path needs to be determined before `relativePath` can be created
    String get relativePath;
    String get fullPath;
}

class EpubLocation {
    // TODO: https://idpf.org/epub/linking/cfi/epub-cfi.html
    final String rawCfi;
    // ...
}

class EpubReadingProgress {
    final EpubLocation location;
    final int percent;
    final int estimatedPage;
    final int estimatedPageCount;
    // ...
}

class EpubLocationList extends List<EpubLocation> {
    EpubLocation peek() => this[length - 1];
    void push(EpubLocation);
    EpubLocationList popFrom(EpubLocation);
    EpubLocation pop();
    // ...
}

class EpubSchema {
    final EpubPackage package;
    final EpubContainer container;
    final EpubNavigation navigation;
    // ...
}

// ---- Files ----

abstract EpubFile {
    final EpubPath path;
    /// The media-type / mimetype declared in the EPUB
    ///
    /// `ContentType` is also from the package `universal_io`
    final io.ContentType type;
    final EpubParseController controller;
    const EpubFile({this.path, this.type, this.controller});
    
    Future<List<int>> readAsBytes() {
        return controller.getFileAsBytes(path);
    };

    Future<String> readAsString() async {
        List<int> bytes = await controller.getFileBytes(path);
        // TODO: This should use an isolate to avoid skipped frames
        // TODO: Should this use `String.fromCharCodes`?
        return utf8.decode(bytes);
    };

    // ...
}

class EpubHtmlFile extends EpubFile {
    const EpubHtmlFile({super.path, super.type, super.controller});
    // `Document` from "https://pub.dev/packages/html" as html;
    Future<html.Document> readAsDocument();
    // ...
}

class EpubCssFile extends EpubFile {
    const EpubCssFile({super.path, super.type, super.controller});
    // `StyleSheet` from "https://pub.dev/packages/csslib" as css;
    Future<css.StyleSheet> readAsStylesheet();
    // ...
}

class EpubImageFile extends EpubFile {
    const EpubImageFile({super.path, super.type, super.controller});
    /// `Image` from "https://pub.dev/packages/image" as img;
    Future<img.Image> readAsImage();
    // ...
}
```

## flutter_shu_epub

### Getting Started

Create an `EpubController` with the data of the EPUB file. It is very important that the controller is not initialized in the `build` method.

```dart
// !!! Do not do this in the build method.
final controller = EpubController(bytes);
final controllerFromBytes = EpubController.fromBytes(bytes);
// If `openInPlace` is `true`, the EPUB file must be saved in the app's directory (someplace the app has access to)
final controllerFromFile = await EpubController.fromFile(file, openInPlace: false);

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

\*`Epub Cfi` stands for `Epub Canonical Fragment Identifiers`, see the [specification](https://idpf.org/epub/linking/cfi/epub-cfi.html) for more detail. TLDR, it is the link format used by EPUBs.

### Widgets

#### Table of Contents

Displays the table of contents in a scrollable list. It will automatically scroll to the current chapter if it is provided.

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

#### Epub Go History

Use this widget to access the jump history of an `EpubController`. The widget will be rebuilt when the jump history changes.

The history is kept in two stacks, one for previous locations and one for forward locations. When a jump is made the previous location CFI is added to the previous locations stack. If the user jumps back the previous location, it is moved to the forward locations stack. The forward locations stack is cleared on page scroll.

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

#### EpubView

**Note:** The implementation of this is still in the experimental stages. Any help would be greatly appreciated. We need to somehow determine how much html text can fit on a page, and where the html for an arbitrary page starts and ends.

Ideally, I would like to be able to render the html natively in Flutter, but it needs to be done in a way that can determine the height of the widget before layout. Current Flutter Html packages do not support getting the height before layout. Another option is to render the html in a webview, but this greatly complicates making `flutter_shu_epub` a cross platform library.

As of now, it seems the best option is to create a custom Flutter html package which allows viewing the height before layout, using `TextPainter`, with `getPositionForOffset`. It should only support the most common html formatting such as bold and italics.

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

### Implementation

#### Widget Implementation

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
        final toc = controller.getTableOfContents();
        return ListView.builder(/** items **/);
    }
}
```

#### Objects

These are not widgets but are Flutter related.

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

## shu_core

- Only the core classes unrelated to epubs, with the goal of adding support for other ebook standards.
- `shu_epub` would depend on and export `shu_core`.

## flutter_shu_reader

- Same as `shu_core` but for the Flutter widgets.
- `flutter_shu_reader` would export `shu_core`.
- `flutter_shu_epub` and related packages would be optional packages to add support for specific filetypes.
