# epub_master

A Flutter package build from the ground up for parsing EPUB files.

## Features

* [ ] EPUB Parser
* [ ] CFI Generator

and more...

## Plans

* shu_epub (this package)
  * Models
  * Parsers which parse individual files, they do not need the entire
  EPUB loaded into memory. Parser take the bytes of the file needed to
  be parsed. This allows the device to save on memory since it will
  not need to have the entire EPUB loaded into memory.
  * EPUB Reader which takes the entire bytes of a `.epub` file
  * Export Parsers and Models to allow custom platform specific
  implementations that could involve caching.
* flutter_shu_epub
  * Uses Models and Parsers from dart_epub
  * Platform specific implementation to handle caching, only loads the
  files it needs into memory
  * Controllers
    * [EpubArchiveController]
      * Reads entire `.epub` file into memory, gives access to the Epub
      object and is used in the provided widgets
    * [EpubCacheController]
      * Reads from a `.epub` file extracted onto the file system, so
      only the files needed are loaded into memory
    * [EpubCacheManagerSingleton]
      * Function to read an `.epub` file into memory and
      cache it on local storage for quick access later, with an optional
      id. If no id is given, the generated id is returned and should be
      saved with something
      such as Hive
      * Local Database for each cached EPUB with [EpubCache], which includes
      information about the EPUB and the [EpubCacheController] associated
      with it
      * Clear cache
      * Delete epub from cache
      * Get all cached epub information
  * [EpubCache]
    * uid, can be specified
    * epub name
    * original filename
    * cache path,
    * epubCacheController
  * Widgets for reading and viewing epub information
    * Table of Contents Panel (Side panel, bottom sheet, or whole/half page)
    * Contents View (Vertical scrolling or paged)
      * Loading view while reading from `.xhtml` file
      * Text selection
        * Add buttons to popup
        * Custom text selection popup builder
      * Text highlighting (maybe use CFI?)
      * Option to override font, font size, line spacing
      * Go to CFI location (scroll or page)
      * Go to CFI History
    * Bookmark support (through CFIs)

## Resources

* [EPUB Specifications](http://idpf.org/epub/dir/)
* [EPUB Accessibility 1.0](http://idpf.org/epub/a11y/accessibility.html)
* [Schema.org Accessibility Properties for Discoverability Vocabulary](https://www.w3.org/2021/a11y-discov-vocab/latest/)
