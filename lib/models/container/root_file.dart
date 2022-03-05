part of shu_epub.models;

class RootFile extends Equatable {
  /// Relative to the root directory for the Abstract Container and not relative to the META-INF/ directory
  final String fullPath;

  /// Mimetype of the file
  final String mediaType;

  // GENERATED DO NOT MODOFY

  const RootFile({
    required this.fullPath,
    required this.mediaType,
  });

  RootFile copyWith({
    String? fullPath,
    String? mediaType,
  }) {
    return RootFile(
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

  factory RootFile.fromMap(Map<String, dynamic> map) {
    return RootFile(
      fullPath: map['fullPath'] ?? '',
      mediaType: map['mediaType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RootFile.fromJson(String source) =>
      RootFile.fromMap(json.decode(source));

  @override
  String toString() => 'RootFile(fullPath: $fullPath, mediaType: $mediaType)';

  @override
  List<Object> get props => [fullPath, mediaType];
}
