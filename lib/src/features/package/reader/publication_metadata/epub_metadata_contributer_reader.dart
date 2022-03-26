part of shu_epub.features.package.reader;

class EpubMetadataContributerReader {
  /// Create an [EpubMetadataContributer] object from the contributer or author XmlElement.
  ///
  /// Throws [EpubException] if the contributer or author element is not the root node
  static EpubMetadataContributer fromXmlElement(XmlElement element) {
    if (element.name.qualified ==
        EpubMetadataContributer.contributorElementName) {
      final controller =
          EpubMetadataContributorController.fromXmlElement(element);
      return _fromContributorController(controller);
    } else {
      final controller = EpubMetadataCreatorController.fromXmlElement(element);
      return _fromCreatorController(controller);
    }
  }

  /// Create an instance of [EpubMetadataContributer] from the [String] representation
  /// of the contributer or author element
  ///
  /// Throws [EpubException] if the string does not have the contributer or author element
  static EpubMetadataContributer fromString(String content) {
    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final dccontributorElement = xmlDocument
        .findElements(EpubMetadataContributer.contributorElementName)
        .firstOrNull;

    if (dccontributorElement == null) {
      final controller = EpubMetadataContributorController.fromString(content);
      return _fromContributorController(controller);
    } else {
      final controller = EpubMetadataCreatorController.fromString(content);
      return _fromCreatorController(controller);
    }
  }

  /// Create an instance of [EpubMetadataContributer] from the [Uint8List] data
  /// of the contributer or author element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the contributer or author element
  static EpubMetadataContributer fromData(Uint8List data) {
    final String content = utf8.decode(
      data,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final dccontributorElement =
        xmlDocument.findElements(EpubMetadataContributer.contributorElementName).firstOrNull;

    if (dccontributorElement == null) {
      final controller = EpubMetadataContributorController(data);
      return _fromContributorController(controller);
    } else {
      final controller = EpubMetadataCreatorController(data);
      return _fromCreatorController(controller);
    }
  }

  static EpubMetadataContributer _fromContributorController(
    EpubMetadataContributorController controller,
  ) {
    return EpubMetadataContributer(
      name: controller.getName(),
      fileAs: controller.getFileAs(),
      role: controller.getRole(),
    );
  }

  static EpubMetadataContributer _fromCreatorController(
    EpubMetadataCreatorController controller,
  ) {
    return EpubMetadataContributer(
      name: controller.getName(),
      fileAs: controller.getFileAs(),
      role: controller.getRole(),
    );
  }
}
