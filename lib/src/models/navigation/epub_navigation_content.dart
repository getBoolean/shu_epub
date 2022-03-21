part of shu_epub.models;

/// Content Element - pointer into XML to beginning of navPoint.
class EpubNavigationContent extends Equatable {
  final String sourcePath;
  final String? id;

  const EpubNavigationContent({
    required this.sourcePath,
    this.id,
  });

  EpubNavigationContent copyWith({
    String? sourcePath,
    String? id,
  }) {
    return EpubNavigationContent(
      sourcePath: sourcePath ?? this.sourcePath,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sourcePath': sourcePath,
      'id': id,
    };
  }

  factory EpubNavigationContent.fromMap(Map<String, dynamic> map) {
    return EpubNavigationContent(
      sourcePath: map['sourcePath'] ?? '',
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationContent.fromJson(String source) =>
      EpubNavigationContent.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubNavigationContent(sourcePath: $sourcePath, id: $id)';

  @override
  List<Object> get props => [sourcePath, id ?? 'no id'];
}
