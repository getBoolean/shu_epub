# shu_epub

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/getBoolean/shu_epub)

[![codecov](https://codecov.io/gh/getBoolean/shu_epub/branch/main/graph/badge.svg?token=LN8VSR2UER)](https://codecov.io/gh/getBoolean/shu_epub)

A Dart EPUB parser built from the ground up, and designed to support a variety of use cases and custom implementations such as on-device caching and serving content from a server. This package is current WIP and is NOT yet usuable.

## Planned Features

* EpubController - An abstract class intended to be extended to enable flexibility inspired by Flutter's Widget class
* EpubArchiveController - Implements EpubController, reads in bytes of an .epub file for reading
* (flutter_shu_epub) EpubCacheController - Extracts ePub contents onto an Android or iOS device and caches the location, allowing for
the reader to only load the needed files into memory

and more...

## Progress and Plans

### shu_epub (this package)

* Provided EpubArchiveController for reading EPUB files, independent from dart:io
* Abstract EpubController for custom implementations, such as serving epubs from
the web or caching epubs on the file system.
* Readers which read individual file data, they do not need the entire
EPUB loaded into memory. This allows the device to save memory.
* Models
  * **Epub**
  * Container
    * **ContainerFile**
    * **Rootfile**
  * Package
    * **PackageFile**
    * **PackageIdentity**
    * **PackageMetadata**
  * **Exception**
  * ... many more
* Controllers
  * **EpubController**
    * Abstract
    * Future getFilePaths - Method to get filepaths to all files
    * Future getFileBytes - Method to get bytes of file from filepath
    * Create instance of EPUB object when controller is created
    * Getter for EPUB object
  * **EpubArchiveController** extends **EpubController**
    * Creates EPUB object from loaded `.epub` file bytes, and supported media types
    * Overrides getFilePaths and getFileBytes to use `Archive`/`ArchiveFile`
  * **EpubContainerController**
    * Given container (`META-INF/container.xml`) file bytes, and supported media types
  * **EpubPackageController**
    * Given rootfile (`.opf`) file bytes
  * **EpubNavigationController**
    * Given navigation (`.ncx`) file bytes
  * **EpubContentsController**
    * Given file content bytes and the type and content it is (such as `.xhtml`)

* [ ] EpubContainerController
  * [x] Default constructor
  * [x] fromString factory
  * [x] getVersion
  * [x] getRootfiles
  * [ ] Tests
* [ ] EpubPackageController
  * [x] Default constructor
  * [x] fromString factory
  * [x] getPackageIdentity
  * [x] getPublicationMetadata
  * [x] getManifest
  * [x] getSpine
  * [ ] getGuide
  * [ ] getTours
  * [ ] Support Epub 2 [Out-Of-Line XML Islands](http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.3.1.2), removed in Epub 3
* [ ] Navigation Controller
  * [x] Default constructor
  * [x] fromString factory
  * [ ] getVersion
  * [ ] getLanguage
  * [ ] getHead
  * [ ] getDocTitle
  * [ ] getDocAuthors
  * [ ] getNavigationMap
  * [ ] getPageList
  * [ ] getNavigationLists
* [ ] Publication/Content Controller
* [ ] EpubBook class to simplify access to Epub content and metadata
* [ ] CFI Generator

### flutter_shu_epub (tenative)

* Uses Models and Parsers from dart_epub
* Platform specific implementation to handle caching, only loads the
files it needs into memory
* Controllers
  * **EpubCacheController** extends **EpubController**
    * Reads from a `.epub` file extracted onto the file system, so
    only the files needed are loaded into memory
    * Overrides getFilePaths and getFileBytes to use dart:io `File`
  * **EpubCacheManagerSingleton**
    * Function to read an `.epub` file into memory and
    cache it on local storage for quick access later, with an optional
    id. The id is returned and it should be saved persistently with
    a package such as Hive
    * Local Database for each cached EPUB with **EpubCache**, which includes
    information about the EPUB and the **EpubCacheController** associated
    with it
    * Clear cache
    * Delete epub from cache
    * Get all cached epub information
* Models
  * **EpubCache**
    * uid, can be specified
    * epub name
    * original filename
    * cache path
    * epubCacheController
* Widgets
  * Table of Contents Panel (Side panel, bottom sheet, or whole/half page)
  * Contents View (Vertical scrolling or paged)
    * Loading view while reading from `.xhtml` file
    * How HTML+CSS is rendered is TBD
    * Text selection
      * Add buttons to popup
      * Custom text selection popup builder
    * Text highlighting (maybe use CFIs?)
    * Option to override font, font size, line spacing
    * Go to CFI location (scroll or page)
    * Go to CFI History
    * Optional page between chapters
    * Page turn transitions
    * Bookmark support (through CFIs)
    * Searchable
  * Epub Title
  * Pictures ListView
  * Search Panel/Page
    * Search current chapter or all chapters

## Testing

Run tests with the following command

> `dart test`

### Test Coverage

Generate test coverage by running the following commands

1. `dart pub global activate coverage`
2. `dart test --coverage="coverage"`
3. `dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage.lcov --packages=.packages --report-on=lib`

## Resources

* [EPUB Specifications](http://idpf.org/epub/dir/)
* [EPUB Accessibility 1.0](http://idpf.org/epub/a11y/accessibility.html)
* [Schema.org Accessibility Properties for Discoverability Vocabulary](https://www.w3.org/2021/a11y-discov-vocab/latest/)
