part of shu_epub.features.package.data;

class EpubExtraMetadata extends EquatableXml {
  static const elementName = 'meta';

  final String? name;
  final String? content;

  const EpubExtraMetadata({
    this.name,
    this.content,
  });

  EpubExtraMetadata copyWith({
    String? name,
    String? content,
  }) {
    return EpubExtraMetadata(
      name: name ?? this.name,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'content': content,
    };
  }

  factory EpubExtraMetadata.fromMap(Map<String, dynamic> map) {
    return EpubExtraMetadata(
      name: map['name'],
      content: map['content'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubExtraMetadata.fromJson(String source) =>
      EpubExtraMetadata.fromMap(json.decode(source));

  @override
  String toString() => 'EpubExtraMetadata(name: $name, content: $content)';

  @override
  List<Object> get props => [name ?? 'no name', content ?? 'no content'];

  @override
  String toXmlString() => '<$elementName'
      '${name != null ? ' name="$name"' : ''}'
      '${content != null ? ' content="$content"' : ''}'
      '/>';
}
