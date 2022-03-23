part of shu_epub.readers;

class EpubSingleTourReader {

  /// Create an [EpubSingleTour] object from the tour XmlElement.
  ///
  /// Throws [EpubException] if the tour element is not the root node
  static EpubSingleTour fromXmlElement(XmlElement tourElement) {
    final controller = EpubSingleTourController.fromXmlElement(tourElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubSingleTour] from the [String] representation
  /// of the tour element
  ///
  /// Throws [EpubException] if the string does not have the tour element
  static EpubSingleTour fromString(String tourString) {
    final controller = EpubSingleTourController.fromString(tourString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubSingleTour] from the [Uint8List] data
  /// of the tour element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the tour element
  static EpubSingleTour fromData(Uint8List tourData) {
    final controller = EpubSingleTourController(tourData);
    return _fromController(controller);
  }

  static EpubSingleTour _fromController(
    EpubSingleTourController controller,
  ) {
    return EpubSingleTour(sites: controller.getSites());
  }
}