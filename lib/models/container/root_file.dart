part of shu_epub.models;

class Rootfile extends Equatable {
  /// Relative to the root directory for the Abstract Container and not relative to the META-INF/ directory
  final String fullPath;

  /// Mimetype of the file
  final String mediaType;

  // GENERATED DO NOT MODOFY

  const Rootfile({
    required this.fullPath,
    required this.mediaType,
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
  String toString() => 'RootFile(fullPath: $fullPath, mediaType: $mediaType)';

  @override
  List<Object> get props => [fullPath, mediaType];
}
