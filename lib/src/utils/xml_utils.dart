part of shu_epub.utils;

class XmlUtils {
  /// Convert String to `XmlDocument`.
  ///
  /// Throws [EpubException] if it is not a valid Xml Document.
  static XmlDocument parseToXmlDocument(String content) {
    try {
      return XmlDocument.parse(content);
    } on XmlParserException catch (e, st) {
      throw EpubException(
        'Epub Parsing Exception: Uint8List given was not a valid xml file',
        e,
        st,
      );
    }
  }

  /// Convert String to `XmlDocument`.
  ///
  /// Returns null if it is not a valid Xml Document.
  static XmlDocument? tryParseToXmlDocument(String content) {
    try {
      return parseToXmlDocument(content);
    } on EpubException catch (_, __) {
      return null;
    }
  }
}
