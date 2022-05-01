part of shu_epub.features.navigation.reader;

class EpubNavigationPageListReader {
  /// Create an [EpubNavigationPageList] object from the pageList XmlElement.
  ///
  /// Throws [EpubException] if the pageList element is not the root node
  static EpubNavigationPageList fromXmlElement(XmlElement pageListElement) {
    final controller =
        EpubNavigationPageListReaderController.fromXmlElement(pageListElement);
    return _fromController(controller);
  }

  static EpubNavigationPageList fromXmlString(String pageListString) {
    final controller =
        EpubNavigationPageListReaderController.fromXmlString(pageListString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationPageList] from the [Uint8List] data
  /// of the pageList element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the pageList element
  static EpubNavigationPageList fromData(Uint8List pageListData) {
    final controller = EpubNavigationPageListReaderController(pageListData);
    return _fromController(controller);
  }

  static EpubNavigationPageList _fromController(
    EpubNavigationPageListReaderController controller,
  ) {
    return EpubNavigationPageList(
      id: controller.getId(),
      classType: controller.getClassType(),
      navigationInfoList: controller.getNavigationInfoList(),
      navigationLabels: controller.getNavigationLabels(),
      pageTargets: controller.getPageTargets(),
    );
  }
}
