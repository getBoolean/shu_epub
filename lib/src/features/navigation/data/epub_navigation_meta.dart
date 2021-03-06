part of shu_epub.features.navigation.data;

/// Meta Element - metadata about this NCX
@Immutable()
class EpubNavigationMeta extends EquatableXml {
  static const elementName = 'meta';

  /// Due to combatibility reasons, the required meta element's name should be `dtb:id`
  final String? name;
  final String? content;
  final String? scheme;

  /// Create an [EpubNavigationMeta] object from the meta XmlElement.
  ///
  /// Throws [EpubException] if the meta element is not the root node
  factory EpubNavigationMeta.fromXmlElement(XmlElement metaElement) {
    return EpubNavigationMetaReader.fromXmlElement(metaElement);
  }

  factory EpubNavigationMeta.fromXmlString(String metaString) {
    return EpubNavigationMetaReader.fromXmlString(metaString);
  }

  /// Create an instance of [EpubNavigationMeta] from the [Uint8List] data
  /// of the meta element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the meta element
  factory EpubNavigationMeta.fromData(Uint8List metaData) {
    return EpubNavigationMetaReader.fromData(metaData);
  }

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
      name: map['name'],
      content: map['content'],
      scheme: map['scheme'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationMeta.fromJson(String source) =>
      EpubNavigationMeta.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubNavigationMeta(name: $name, content: $content, scheme: $scheme)';

  @override
  List<Object> get props => [
        name ?? 'no name',
        content ?? 'no content',
        scheme ?? 'no scheme specified'
      ];

  @override
  String toXmlString() => '<$elementName'
      '${name != null ? ' name="$name"' : ''}'
      '${content != null ? ' content="$content"' : ''}'
      '${scheme != null ? ' scheme="$scheme"' : ''}'
      '/>';
}
