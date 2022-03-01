part of shu_epub.models;

class EpubMediaTypes {
  /// Epub media type
  static const kEpubMimeType = 'application/epub+zip';

  /// Epub rootfile (.opf) media type
  static const kOPFMimeType = 'application/oebps-package+xml';

  /// GIF, JPEG, PNG, and SVG
  static const kImageMimeTypes = [
    'image/gif',
    'image/jpeg',
    'image/png',
    'image/svg+xml'
  ];

  /// MP3, and AAC LC audio using MP4 container
  static const kAudioMimeTypes = [
    'audio/mpeg',
    'audio/mp4',
  ];

  /// CSS Style Sheets
  static const kCSSStyleMimeType = 'text/css';

  /// TrueType, OpenType, WOFF, and WOFF2 Fonts
  static const kFontMimeTypes = [
    // TrueType fonts
    'font/ttf',
    'application/font-sfnt',
    // OpenType fonts
    'font/otf',
    'application/font-sfnt',
    'application/vnd.ms-opentype',
    // WOFF fonts
    'font/woff',
    'application/font-woff',
    // WOFF2 fonts
    'font/woff2',
  ];

  /// XHTML Content Documents
  static const kXHTMLMimeType = 'xhtml';

  /// JavaScript
  static const kJavaScriptMimeTypes = [
    'application/javascript',
    'text/javascript',
  ];

  /// EPUB Media Overlay documents: [MediaOverlays32](https://www.w3.org/publishing/epub32/epub-spec.html#bib-mediaoverlays32)
  static const kMediaOverlaysMimeType = 'application/smil+xml';

  /// [Text-to-Speech](https://www.w3.org/publishing/epub32/epub-spec.html#dfn-text-to-speech) (TTS) Pronunciation lexicons: [PRONUNCIATION-LEXICON](https://www.w3.org/publishing/epub32/epub-spec.html#bib-pronunciation-lexicon)
  static const kPronounciationLexiconMimeType = 'application/pls+xml';

  /// All mime types supported by EPUB 3
  static List<String> get values => [
        ...kImageMimeTypes,
        ...kAudioMimeTypes,
        ...kFontMimeTypes,
        ...kJavaScriptMimeTypes,
        kCSSStyleMimeType,
        kXHTMLMimeType,
        kMediaOverlaysMimeType,
        kPronounciationLexiconMimeType,
      ];
}
