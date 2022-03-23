part of shu_epub.models;

/// The container.xml file contains XML that uses the `urn:oasis:names:tc:opendocument:xmlns:container`
/// namespace for all of its elements and attributes. The `version="1.0"` attribute MUST be included
/// for all containers that conform to this version of the specification.
///
/// The rootfiles element MUST contain at least one <rootfile> element that has a media-type of `application/oebps-package+xml`.
class EpubContainer extends Equatable {
  static const elementName = 'container';
  static const namespace = 'urn:oasis:names:tc:opendocument:xmlns:container';
  static const filepath = 'META-INF/container.xml';

  final List<Rootfile> rootfileList;
  final String containerVersion;

  /// If there are multiple [Rootfile]s with mime type [EpubXMLConstants.kOPFMimeType], the first one will be considered the rootfile
  ///
  /// Returns null if [EpubContainer.rootfileList] is empty
  Rootfile? get rootfile {
    return rootfileList.firstWhereOrNull(
      (element) => element.mediaType == EpubMediaTypes.kOPFMimeType,
    );
  }

  factory EpubContainer.zero() {
    return EpubContainer(containerVersion: '', rootfileList: []);
  }

  factory EpubContainer.error(Rootfile epubRootfile) {
    return EpubContainer(
        rootfileList: [epubRootfile], containerVersion: 'unknown');
  }

  factory EpubContainer.fromData(Uint8List data) {
    return EpubContainerReader.fromData(data);
  }

  factory EpubContainer.fromArchive(Archive archive) {
    return EpubContainerReader.fromArchive(archive);
  }

  // GENERATED DO NOT MODOFY

  const EpubContainer({
    required this.rootfileList,
    required this.containerVersion,
  });

  EpubContainer copyWith({
    List<Rootfile>? rootfileList,
    String? containerVersion,
  }) {
    return EpubContainer(
      rootfileList: rootfileList ?? this.rootfileList,
      containerVersion: containerVersion ?? this.containerVersion,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rootfileList': rootfileList.map((x) => x.toMap()).toList(),
      'containerVersion': containerVersion,
    };
  }

  factory EpubContainer.fromMap(Map<String, dynamic> map) {
    return EpubContainer(
      rootfileList:
          List<Rootfile>.from(map['rootfileList']?.map(Rootfile.fromMap)),
      containerVersion: map['containerVersion'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubContainer.fromJson(String source) =>
      EpubContainer.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubContainer(rootfileList: $rootfileList, containerVersion: $containerVersion)';

  @override
  List<Object> get props => [rootfileList, containerVersion];
}
