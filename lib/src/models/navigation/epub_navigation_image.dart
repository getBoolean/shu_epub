part of shu_epub.models;

/// Image Element - image that may accompany heading.
class EpubNavigationImage extends Equatable {
  final String? id;
  final String? classType;
  final String? source;

  const EpubNavigationImage({
    this.id,
    this.classType,
    this.source,
  });

  factory EpubNavigationImage.zero() {
    return EpubNavigationImage(source: '');
  }

  EpubNavigationImage copyWith({
    String? id,
    String? classType,
    String? source,
  }) {
    return EpubNavigationImage(
      id: id ?? this.id,
      classType: classType ?? this.classType,
      source: source ?? this.source,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'classType': classType,
      'source': source,
    };
  }

  factory EpubNavigationImage.fromMap(Map<String, dynamic> map) {
    return EpubNavigationImage(
      id: map['id'],
      classType: map['classType'],
      source: map['source'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationImage.fromJson(String source) =>
      EpubNavigationImage.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubNavigationImage(id: $id, classType: $classType, source: $source)';

  @override
  List<Object> get props =>
      [id ?? 'no id', classType ?? 'no classType', source ?? 'no source'];
}
