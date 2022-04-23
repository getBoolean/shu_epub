part of shu_epub.features.container.data;

/// The container.xml file contains XML that uses the `urn:oasis:names:tc:opendocument:xmlns:container`
/// namespace for all of its elements and attributes. The `version="1.0"` attribute MUST be included
/// for all containers that conform to this version of the specification.
///
/// The rootfiles element MUST contain at least one <rootfile> element that has a media-type of `application/oebps-package+xml`.
@Immutable()
class EpubContainer extends EquatableXml {
  static const elementName = 'container';
  static const namespace = 'urn:oasis:names:tc:opendocument:xmlns:container';
  static String get filepath => p.join('META-INF', 'container.xml');

  final RootfileList? rootfileList;
  final String? containerVersion;

  /// If there are multiple [Rootfile]s with mime type [EpubXMLConstants.kOPFMimeType] and non null [Rootfile.fullPath], the first one will be considered the rootfile
  ///
  /// Returns null if [EpubContainer.rootfileList] is empty, no items have OPF media type, or fullPath is null on the only OPF elements
  Rootfile? get rootfile {
    return rootfileList?.items.firstWhereOrNull(
      (element) =>
          element.mediaType == EpubMediaTypes.kOPFMimeType &&
          element.fullPath != null,
    );
  }

  /// Create an [EpubContainer] object from the container XmlElement.
  ///
  /// Throws [EpubException] if the container element is not the root node
  factory EpubContainer.fromXmlElement(XmlElement containerElement) {
    return EpubContainerReader.fromXmlElement(containerElement);
  }

  /// Create an instance of [EpubContainer] from the [String] representation
  /// of the container element
  ///
  /// Throws [EpubException] if the string does not have the container element
  factory EpubContainer.fromXmlString(String containerString) {
    return EpubContainerReader.fromXmlString(containerString);
  }

  /// Create an instance of [EpubContainer] from the [Uint8List] data
  /// of the container element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the container element
  factory EpubContainer.fromData(Uint8List containerData) {
    return EpubContainerReader.fromData(containerData);
  }

  /// Throws [EpubException] if the data does not have the container element
  factory EpubContainer.fromArchive(Archive archive) {
    return EpubContainerReader.fromArchive(archive);
  }

  // GENERATED DO NOT MODOFY

  const EpubContainer({
    this.rootfileList,
    this.containerVersion,
  });

  EpubContainer copyWith({
    RootfileList? rootfileList,
    String? containerVersion,
  }) {
    return EpubContainer(
      rootfileList: rootfileList ?? this.rootfileList,
      containerVersion: containerVersion ?? this.containerVersion,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rootfileList': rootfileList?.toMap(),
      'containerVersion': containerVersion,
    };
  }

  factory EpubContainer.fromMap(Map<String, dynamic> map) {
    return EpubContainer(
      rootfileList: map['rootfileList'] == null
          ? null
          : RootfileList.fromMap(map['rootfileList']),
      containerVersion: map['containerVersion'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubContainer.fromJson(String source) =>
      EpubContainer.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubContainer(rootfileList: $rootfileList, containerVersion: $containerVersion)';

  @override
  List<Object> get props =>
      [rootfileList ?? 'rootfileList', containerVersion ?? 'containerVersion'];

  @override
  String toXmlString() {
    return '<$elementName'
        '${containerVersion != null ? ' version="$containerVersion"' : ''}'
        ' xmlns="$namespace"'
        '>'
        '${rootfileList != null ? rootfileList?.toXmlString() : ''}'
        '</$elementName>';
  }
}
