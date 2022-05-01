part of shu_epub.features.package.reader;

class EpubSingleTourReader {
  /// Create an [EpubSingleTour] object from the tour XmlElement.
  ///
  /// Throws [EpubException] if the tour element is not the root node
  static EpubSingleTour fromXmlElement(XmlElement tourElement) {
    final controller =
        EpubSingleTourReaderController.fromXmlElement(tourElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubSingleTour] from the [String] representation
  /// of the tour element
  ///
  /// Throws [EpubException] if the string does not have the tour element
  static EpubSingleTour fromXmlString(String tourString) {
    final controller = EpubSingleTourReaderController.fromXmlString(tourString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubSingleTour] from the [Uint8List] data
  /// of the tour element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the tour element
  static EpubSingleTour fromData(Uint8List tourData) {
    final controller = EpubSingleTourReaderController(tourData);
    return _fromController(controller);
  }

  static EpubSingleTour _fromController(
    EpubSingleTourReaderController controller,
  ) {
    return EpubSingleTour(
      sites: controller.getSites(),
      id: controller.getId(),
      title: controller.getTitle(),
    );
  }
}
