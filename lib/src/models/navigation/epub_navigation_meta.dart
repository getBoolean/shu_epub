part of shu_epub.models;

/// Meta Element - metadata about this NCX
class EpubNavigationMeta extends Equatable {
  /// Due to combatibility reasons, the required meta element's name should be `dtb:id`
  final String? name;
  final String? content;
  final String? scheme;

  const EpubNavigationMeta({
    this.name,
    this.content,
    this.scheme,
  });

  EpubNavigationMeta copyWith({
    String? name,
    String? content,
    String? scheme,
  }) {
    return EpubNavigationMeta(
      name: name ?? this.name,
      content: content ?? this.content,
      scheme: scheme ?? this.scheme,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'content': content,
      'scheme': scheme,
    };
  }

  factory EpubNavigationMeta.fromMap(Map<String, dynamic> map) {
    return EpubNavigationMeta(
      name: map['name'] ?? '',
      content: map['content'] ?? '',
      scheme: map['scheme'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationMeta.fromJson(String source) =>
      EpubNavigationMeta.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubNagivationMeta(name: $name, content: $content, scheme: $scheme)';

  @override
  List<Object> get props => [
        name ?? 'no name',
        content ?? 'no content',
        scheme ?? 'no scheme specified'
      ];
}
