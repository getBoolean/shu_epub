part of shu_epub.models;

/// Image Element - image that may accompany heading.
class EpubNavigationImage extends Equatable {
  final String? id;
  final String? classType;
  final String sourcePath;

  const EpubNavigationImage({
    this.id,
    this.classType,
    required this.sourcePath,
  });

  factory EpubNavigationImage.zero() {
    return EpubNavigationImage(sourcePath: '');
  }

  EpubNavigationImage copyWith({
    String? id,
    String? classType,
    String? sourcePath,
  }) {
    return EpubNavigationImage(
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

  factory EpubNavigationImage.fromMap(Map<String, dynamic> map) {
    return EpubNavigationImage(
      id: map['id'],
      classType: map['classType'],
      sourcePath: map['sourcePath'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationImage.fromJson(String source) =>
      EpubNavigationImage.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubNavigationImage(id: $id, classType: $classType, sourcePath: $sourcePath)';

  @override
  List<Object> get props =>
      [id ?? 'no id', classType ?? 'no classType', sourcePath];
}
