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
  cover,
  titlePage,
  toc,
  bookIndex,
  glossary,
  acknowledgements,
  bibliography,
  colophon,
  copyrightPage,
  dedication,
  epigraph,
  foreword,
}

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
