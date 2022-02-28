# epub_master

A Flutter package build from the ground up for parsing EPUB files.

## Features

* [x] Package Parser
* [ ] Container Parser
* [ ] EPUB Parser
* [ ] CFI Generator

and more...

## Plans

### shu_epub (this package)

* Readers which read individual files, they do not need the entire
EPUB loaded into memory. This allows the device to save memory.
* Export Models, Readers, and Controllers to allow custom platform specific
implementations (such as caching).
* Models
* File Readers/Parsers
  * **EpubContainerReader**
  * **EpubPackageReader**
  * **EpubXHtmlFileReader**
* Controllers
  * **EpubController**
    * Abstract
    * getFilePaths - Method to get filepaths to all files
    * getFileBytes - Method to get bytes of file from filepath
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

### flutter_shu_epub

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
