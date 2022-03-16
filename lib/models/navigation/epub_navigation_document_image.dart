part of shu_epub.models;

class EpubNavigationDocumentImage extends Equatable {
  final String sourcePath;
  
  const EpubNavigationDocumentImage({
    required this.sourcePath,
  });

  EpubNavigationDocumentImage copyWith({
    String? sourcePath,
  }) {
    return EpubNavigationDocumentImage(
      sourcePath: sourcePath ?? this.sourcePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sourcePath': sourcePath,
    };
  }

  factory EpubNavigationDocumentImage.fromMap(Map<String, dynamic> map) {
    return EpubNavigationDocumentImage(
      sourcePath: map['sourcePath'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationDocumentImage.fromJson(String source) => EpubNavigationDocumentImage.fromMap(json.decode(source));

  @override
  String toString() => 'EpubNavigationDocumentImage(sourcePath: $sourcePath)';

  @override
  List<Object> get props => [sourcePath];
}
