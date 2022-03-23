part of shu_epub.models;

/// Content Element - pointer into XML to beginning of navPoint.
class EpubNavigationContent extends Equatable {
  final String? source;
  final String? id;

  const EpubNavigationContent({
    this.source,
    this.id,
  });

  EpubNavigationContent copyWith({
    String? source,
    String? id,
  }) {
    return EpubNavigationContent(
      source: source ?? this.source,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'source': source,
      'id': id,
    };
  }

  factory EpubNavigationContent.fromMap(Map<String, dynamic> map) {
    return EpubNavigationContent(
      source: map['source'] ?? '',
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationContent.fromJson(String source) =>
      EpubNavigationContent.fromMap(json.decode(source));

  @override
  String toString() => 'EpubNavigationContent(source: $source, id: $id)';

  @override
  List<Object> get props => [source ?? 'no source', id ?? 'no id'];
}
