# shu_epub

[![codecov](https://codecov.io/gh/getBoolean/shu_epub/branch/main/graph/badge.svg?token=LN8VSR2UER)](https://codecov.io/gh/getBoolean/shu_epub)

A Flutter package build from the ground up for parsing EPUB files.

## Features

* [x] Package Parser
* [ ] Container Parser
* [ ] EPUB Parser
* [ ] CFI Generator

and more...

## Plans

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
    * **RootFile**
  * Package
    * **PackageFile**
    * **PackageIdentity**
    * **PackageMetadata**
  * **Exception**
  * ... (tbd)
* File Readers/Parsers
  * **EpubContainerReader**
    * Given String XML content of `container.xml`
    * Parses using package:xml
    * Returns **ContainerFile**
  * **EpubPackageReader**
    * Given String XML content
    * Parses using package:xml
    * Returns **PackageFile**
  * **EpubXHtmlFileReader**
    * Given String XHtml content
    * Implementation TBD
* Controllers
  * **EpubController**
    * Abstract
    * Future getFilePaths - Method to get filepaths to all files
    * Future getFileBytes - Method to get bytes of file from filepath
    * Create instance of EPUB object when controller is created
    * Getter for EPUB object
  * **EpubArchiveController** extends **EpubController**
    * Creates EPUB object from loaded `.epub` file bytes
    * Overrides getFilePaths and getFileBytes to use `Archive`/`ArchiveFile`
  * **EpubContainerController**
    * Given container (`META-INF/container.xml`) file bytes
    * Uses **EpubContainerReader**
    * Returns list of rootfiles and container version
  * **EpubMetadataController**
    * Given rootfile (`.opf`) file bytes
    * Uses **EpubPackageReader**
    * Returns Epub version and metadata
  * **EpubContentsController**
    * Given XHtml file bytes
    * Uses **EpubXHtmlFileReader**
    * Returns parsed content with inline images

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

## Resources

* [EPUB Specifications](http://idpf.org/epub/dir/)
* [EPUB Accessibility 1.0](http://idpf.org/epub/a11y/accessibility.html)
* [Schema.org Accessibility Properties for Discoverability Vocabulary](https://www.w3.org/2021/a11y-discov-vocab/latest/)
