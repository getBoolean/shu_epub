part of shu_epub.models;

class EpubNavigationHeadMeta extends Equatable {
  /// Due to combatibility reasons, should equal `dtb:id`
  final String name;
  final String content;
  final String scheme;

  const EpubNavigationHeadMeta({
    required this.name,
    required this.content,
    required this.scheme,
  });

  EpubNavigationHeadMeta copyWith({
    String? name,
    String? content,
    String? scheme,
  }) {
    return EpubNavigationHeadMeta(
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

  factory EpubNavigationHeadMeta.fromMap(Map<String, dynamic> map) {
    return EpubNavigationHeadMeta(
      name: map['name'] ?? '',
      content: map['content'] ?? '',
      scheme: map['scheme'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationHeadMeta.fromJson(String source) => EpubNavigationHeadMeta.fromMap(json.decode(source));

  @override
  String toString() => 'EpubNagivationHeadMeta(name: $name, content: $content, scheme: $scheme)';

  @override
  List<Object> get props => [name, content, scheme];
}
