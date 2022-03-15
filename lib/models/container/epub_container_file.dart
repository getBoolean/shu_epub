part of shu_epub.models;

/// The container.xml file contains XML that uses the `urn:oasis:names:tc:opendocument:xmlns:container`
/// namespace for all of its elements and attributes. The `version="1.0"` attribute MUST be included
/// for all containers that conform to this version of the specification.
///
/// The rootfiles element MUST contain at least one <rootfile> element that has a media-type of `application/oebps-package+xml`.
class EpubContainerFile extends Equatable {
  static const kFilePath = 'META-INF/container.xml';
  final List<Rootfile> rootfileList;
  final String containerVersion;

  /// If there are multiple [Rootfile]s with mime type [EpubXMLConstants.kOPFMimeType], the first one will be considered the rootfile
  /// 
  /// Returns null if [EpubContainerFile.rootfileList] is empty
  Rootfile? get rootfile => rootfileList.firstWhereOrNull(
        (element) => element.mediaType == EpubMediaTypes.kOPFMimeType
      );

  factory EpubContainerFile.error(Rootfile epubRootfile) {
    return EpubContainerFile(
        rootfileList: [epubRootfile], containerVersion: 'unknown');
  }

  factory EpubContainerFile.fromData(Uint8List data) {
    return EpubContainerReader.fromData(data);
  }

  factory EpubContainerFile.fromArchive(Archive archive) {
    return EpubContainerReader.fromArchive(archive);
  }

  // GENERATED DO NOT MODOFY

  const EpubContainerFile({
    required this.rootfileList,
    required this.containerVersion,
  });

  EpubContainerFile copyWith({
    List<Rootfile>? rootfileList,
    String? containerVersion,
  }) {
    return EpubContainerFile(
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

  factory EpubContainerFile.fromMap(Map<String, dynamic> map) {
    return EpubContainerFile(
      rootfileList: List<Rootfile>.from(
          map['rootfileList']?.map((x) => Rootfile.fromMap(x))),
      containerVersion: map['containerVersion'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubContainerFile.fromJson(String source) =>
      EpubContainerFile.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubContainerFile(rootfileList: $rootfileList, containerVersion: $containerVersion)';

  @override
  List<Object> get props => [rootfileList, containerVersion];
}
