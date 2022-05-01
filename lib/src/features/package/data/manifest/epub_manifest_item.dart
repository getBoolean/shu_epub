part of shu_epub.features.package.data;

@Immutable()
class EpubManifestItem extends EquatableXml {
  static const elementName = 'item';

  final String? id;
  final String? href;
  final String? mediaType;

  /// If a `fallback` attribute points to an [EpubManifestItem]'s `id`
  /// that also has a `fallback` attribute, a Reading System **must** continue
  /// down the fallback chain until it reaches a reference to an [EpubManifestItem]
  /// with a media type it can display (or as specified below, it reaches
  /// an item with a `fallback-style` attribute). A Reading System **may**
  /// continue further, and **may** display any item from the chain. In the
  /// absence of element-specific (i.e. `img` and `object`) fallback information,
  /// every [EpubManifestItem] in a publication that does not have one of the OPS Core Media
  /// Types **must**, directly or indirectly, specify a fallback to an item
  /// that does have one of the OPS Core Media Types (or as specified
  /// below, an [EpubManifestItem] with a `fallback-style` attribute).
  ///
  /// Fallback chains **must** terminate; circular references are not permitted.
  /// Nevertheless, Reading Systems **should not** fail catastrophically if
  /// they encounter such a loop.
  final String? fallback;

  /// Create an [EpubManifestItem] object from the item XmlElement.
  ///
  /// Throws [EpubException] if the item element is not the root node
  factory EpubManifestItem.fromXmlElement(XmlElement itemElement) {
    return EpubManifestItemReader.fromXmlElement(itemElement);
  }

  /// Create an instance of [EpubManifestItem] from the [String] representation
  /// of the item element
  ///
  /// Throws [EpubException] if the string does not have the item element
  factory EpubManifestItem.fromXmlString(String itemString) {
    return EpubManifestItemReader.fromXmlString(itemString);
  }

  /// Create an instance of [EpubManifestItem] from the [Uint8List] data
  /// of the item element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the item element
  factory EpubManifestItem.fromData(Uint8List itemData) {
    return EpubManifestItemReader.fromData(itemData);
  }

  const EpubManifestItem({
    this.id,
    this.href,
    this.mediaType,
    this.fallback,
  });

  EpubManifestItem copyWith({
    String? id,
    String? href,
    String? mediaType,
    String? fallback,
  }) {
    return EpubManifestItem(
      id: id ?? this.id,
      href: href ?? this.href,
      mediaType: mediaType ?? this.mediaType,
      fallback: fallback ?? this.fallback,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'href': href,
      'media-type': mediaType,
      'fallback': fallback,
    };
  }

  factory EpubManifestItem.fromMap(Map<String, dynamic> map) {
    return EpubManifestItem(
      id: map['id'],
      href: map['href'],
      mediaType: map['media-type'],
      fallback: map['fallback'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubManifestItem.fromJson(String source) =>
      EpubManifestItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubManifestItem(id: $id, href: $href, mediaType: $mediaType, fallback: $fallback)';
  }

  @override
  List<Object> get props {
    return [
      id ?? 'no id',
      href ?? 'no href',
      mediaType ?? 'no mediaType',
      fallback ?? 'no fallback',
    ];
  }

  @override
  String toXmlString() => '<$elementName'
      '${id != null ? ' id="$id"' : ''}'
      '${href != null ? ' href="$href"' : ''}'
      '${mediaType != null ? ' media-type="$mediaType"' : ''}'
      '${fallback != null ? ' fallback="$fallback"' : ''}'
      '/>';
}
