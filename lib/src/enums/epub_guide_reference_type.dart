part of shu_epub.enums;

/// The following list of type values is derived from the 13th edition of the Chicago Manual of Style:
///
/// Use `EpubGuideReferenceType.{enum_item}.value` to get the string equivalent.
/// Do NOT use `EpubGuideReferenceType.{enum_item}.name`
///
/// For example:
///
/// `EpubGuideReferenceType.titlePage.value`
///
/// returns `title-page`
enum EpubGuideReferenceType {
  /// Image cover page
  cover,

  /// Title page
  titlePage,

  /// Table of contents
  toc,

  /// Book Index
  bookIndex,

  /// Glossary
  glossary,

  /// Acknowledgements
  acknowledgements,

  /// Bibliography
  bibliography,

  /// Colophon
  colophon,

  /// Copyright page
  copyrightPage,

  /// Dedication
  dedication,

  /// Epigraph (Short quotation or saying at the beginning of a book, chapter or article)
  epigraph,

  /// Foreword (Piece of writing sometimes placed at the beginning of a book or other piece of literature)
  foreword,
}

/// Extension for converting [EpubGuideReferenceType] to a string.
extension EpubGuideReferenceTypeExtension on EpubGuideReferenceType {
  /// The string equivalent of this constant property used in EPUBs
  String get value {
    switch (this) {
      case EpubGuideReferenceType.cover:
        return 'cover';
      case EpubGuideReferenceType.titlePage:
        return 'title-page';
      case EpubGuideReferenceType.toc:
        return 'toc';
      case EpubGuideReferenceType.bookIndex:
        return 'index';
      case EpubGuideReferenceType.glossary:
        return 'glossary';
      case EpubGuideReferenceType.acknowledgements:
        return 'acknowledgements';
      case EpubGuideReferenceType.bibliography:
        return 'bibliography';
      case EpubGuideReferenceType.colophon:
        return 'colophon';
      case EpubGuideReferenceType.copyrightPage:
        return 'copyright-page';
      case EpubGuideReferenceType.dedication:
        return 'dedication';
      case EpubGuideReferenceType.epigraph:
        return 'epigraph';
      case EpubGuideReferenceType.foreword:
        return 'foreword';
    }
  }
}
