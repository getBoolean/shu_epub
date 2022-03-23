part of shu_epub.readers;

class EpubTourSiteReader {

  /// Create an [EpubTourSite] object from the site XmlElement.
  ///
  /// Throws [EpubException] if the site element is not the root node
  static EpubTourSite fromXmlElement(XmlElement siteElement) {
    final controller = EpubTourSiteController.fromXmlElement(siteElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubTourSite] from the [String] representation
  /// of the site element
  ///
  /// Throws [EpubException] if the string does not have the site element
  static EpubTourSite fromString(String siteString) {
    final controller = EpubTourSiteController.fromString(siteString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubTourSite] from the [Uint8List] data
  /// of the site element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the site element
  static EpubTourSite fromData(Uint8List siteData) {
    final controller = EpubTourSiteController(siteData);
    return _fromController(controller);
  }

  static EpubTourSite _fromController(
    EpubTourSiteController controller,
  ) {
    return EpubTourSite(
      title: controller.getTitle(),
      href: controller.getHref(),
    );
  }
}