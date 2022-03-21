part of shu_epub.models;

/// Image Element - image that may accompany heading.
class EpubNavigationDocumentImage extends Equatable {
  final String? id;
  final String? classType;
  final String sourcePath;

  const EpubNavigationDocumentImage({
    this.id,
    this.classType,
    required this.sourcePath,
  });

  factory EpubNavigationDocumentImage.zero() {
    return EpubNavigationDocumentImage(sourcePath: '');
  }

  EpubNavigationDocumentImage copyWith({
    String? id,
    String? classType,
    String? sourcePath,
  }) {
    return EpubNavigationDocumentImage(
      id: id ?? this.id,
      classType: classType ?? this.classType,
      sourcePath: sourcePath ?? this.sourcePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'classType': classType,
      'sourcePath': sourcePath,
    };
  }

  factory EpubNavigationDocumentImage.fromMap(Map<String, dynamic> map) {
    return EpubNavigationDocumentImage(
      id: map['id'],
      classType: map['classType'],
      sourcePath: map['sourcePath'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationDocumentImage.fromJson(String source) =>
      EpubNavigationDocumentImage.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubNavigationDocumentImage(id: $id, classType: $classType, sourcePath: $sourcePath)';

  @override
  List<Object> get props =>
      [id ?? 'no id', classType ?? 'no classType', sourcePath];
}
