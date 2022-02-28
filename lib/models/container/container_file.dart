part of epub_master.models;

/// The container.xml file contains XML that uses the `urn:oasis:names:tc:opendocument:xmlns:container`
/// namespace for all of its elements and attributes. The `version="1.0"` attribute MUST be included
/// for all containers that conform to this version of the specification.
///
/// The rootfiles element MUST contain at least one <rootfile> element that has a media-type of `application/oebps-package+xml`.
class ContainerFile extends Equatable {
  static const filepath = 'META-INF/container.xml';
  final List<RootFile> rootfileList;
  final String containerVersion;

  /// If there are multiple [RootFile]s with mime type [EpubConstants.kOPFMimeType], the first one will be considered the rootfile
  RootFile get rootfile => rootfileList.firstWhere(
        (element) => element.mediaType == EpubConstants.kOPFMimeType,
        orElse: () {
          throw EpubException(
              'Epub Parsing Exception: EPUB container at path "${ContainerFile.filepath}" does not contain an element with media-type attribute value of "${EpubConstants.kOPFMimeType}"');
        },
      );

  factory ContainerFile.error(RootFile epubRootfile) {
    return ContainerFile(rootfileList: [epubRootfile], containerVersion: 'unknown');
  }

  factory ContainerFile.read(Archive archive) {
    return ContainerReader.parse(archive);
  }

  // GENERATED DO NOT MODOFY

  ContainerFile({
    required this.rootfileList,
    required this.containerVersion,
  });

  ContainerFile copyWith({
    List<RootFile>? rootfileList,
    String? containerVersion,
  }) {
    return ContainerFile(
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

  factory ContainerFile.fromMap(Map<String, dynamic> map) {
    return ContainerFile(
      rootfileList: List<RootFile>.from(map['rootfileList']?.map((x) => RootFile.fromMap(x))),
      containerVersion: map['containerVersion'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContainerFile.fromJson(String source) =>
      ContainerFile.fromMap(json.decode(source));

  @override
  String toString() => 'ContainerFile(rootfileList: $rootfileList, containerVersion: $containerVersion)';

  @override
  List<Object> get props => [rootfileList, containerVersion];
}
