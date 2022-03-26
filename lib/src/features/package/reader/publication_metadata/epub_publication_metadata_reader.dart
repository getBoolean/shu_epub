part of shu_epub.features.package.reader;

class EpubPublicationMetadataReader {
  /// Create an [EpubPublicationMetadata] object from the metadata XmlElement.
  ///
  /// Throws [EpubException] if the metadata element is not the root node
  static EpubPublicationMetadata fromXmlElement(XmlElement metadataElement) {
    final controller =
        EpubPublicationMetadataController.fromXmlElement(metadataElement);
    return _fromController(controller);
  }

  /// Create an instance of [EpubPublicationMetadata] from the [String] representation
  /// of the metadata element
  ///
  /// Throws [EpubException] if the string does not have the metadata element
  static EpubPublicationMetadata fromString(String metadataString) {
    final controller =
        EpubPublicationMetadataController.fromString(metadataString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubPublicationMetadata] from the [Uint8List] data
  /// of the metadata element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the metadata element
  static EpubPublicationMetadata fromData(Uint8List metadataData) {
    final controller = EpubPublicationMetadataController(metadataData);
    return _fromController(controller);
  }

  static EpubPublicationMetadata _fromController(
    EpubPublicationMetadataController controller,
  ) {
    return EpubPublicationMetadata(
      allTitles: controller.getAllTitles(),
      creators: controller.getCreators(),
      subjects: controller.getSubjects(),
      description: controller.getDescription(),
      publisher: controller.getPublisher(),
      contributors: controller.getContributors(),
      extraMetadataItems: controller.getExtraMetadataItems(),
      metadataDate: controller.getMetadataDate(),
      type: controller.getType(),
      format: controller.getFormat(),
      identifiers: controller.getIdentifiers(),
      source: controller.getSource(),
      languages: controller.getLanguages(),
      relation: controller.getRelation(),
      coverage: controller.getCoverage(),
      rights: controller.getRights(),
    );
  }
}
