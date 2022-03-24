part of shu_epub.features.container.data;

class Rootfile extends Equatable {
  static const elementName = 'rootfile';

  /// Relative to the root directory for the Abstract Container and not relative to the META-INF/ directory
  final String? fullPath;

  /// Mimetype of the file
  final String? mediaType;

  /// Create an [Rootfile] object from the rootfile XmlElement.
  ///
  /// Throws [EpubException] if the rootfile element is not the root node
  factory Rootfile.fromXmlElement(XmlElement rootfileElement) {
    return RootfileReader.fromXmlElement(rootfileElement);
  }

  /// Create an instance of [Rootfile] from the [String] representation
  /// of the rootfile element
  ///
  /// Throws [EpubException] if the string does not have the rootfile element
  factory Rootfile.fromString(String rootfileString) {
    return RootfileReader.fromString(rootfileString);
  }

  /// Create an instance of [Rootfile] from the [Uint8List] data
  /// of the rootfile element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the rootfile element
  factory Rootfile.fromData(Uint8List rootfileData) {
    return RootfileReader.fromData(rootfileData);
  }

  // GENERATED DO NOT MODOFY

  const Rootfile({
    this.fullPath,
    this.mediaType,
  });

  Rootfile copyWith({
    String? fullPath,
    String? mediaType,
  }) {
    return Rootfile(
      fullPath: fullPath ?? this.fullPath,
      mediaType: mediaType ?? this.mediaType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullPath': fullPath,
      'mediaType': mediaType,
    };
  }

  factory Rootfile.fromMap(Map<String, dynamic> map) {
    return Rootfile(
      fullPath: map['fullPath'] ?? '',
      mediaType: map['mediaType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Rootfile.fromJson(String source) =>
      Rootfile.fromMap(json.decode(source));

  @override
  String toString() => 'Rootfile(fullPath: $fullPath, mediaType: $mediaType)';

  @override
  List<Object> get props =>
      [fullPath ?? 'no fullPath', mediaType ?? 'no mediaType'];
}
