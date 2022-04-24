part of shu_epub.features.navigation.data;

@Immutable()
class EpubNavigationHead extends EquatableXml {
  static const elementName = 'head';

  /// metadata about this NCX
  ///
  /// The only required meta is that which contains a content reference to the
  /// OPF unique ID. For backwards compatibility reasons, the value of the name
  /// of that meta remains `dtb:id`.
  final List<EpubNavigationMeta> metadata;

  /// Create an [EpubNavigationHead] object from the head XmlElement.
  ///
  /// Throws [EpubException] if the head element is not the root node
  factory EpubNavigationHead.fromXmlElement(XmlElement headElement) {
    return EpubNavigationHeadReader.fromXmlElement(headElement);
  }

  factory EpubNavigationHead.fromXmlString(String headString) {
    return EpubNavigationHeadReader.fromXmlString(headString);
  }

  /// Create an instance of [EpubNavigationHead] from the [Uint8List] data
  /// of the head element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the head element
  factory EpubNavigationHead.fromData(Uint8List headData) {
    return EpubNavigationHeadReader.fromData(headData);
  }

  const EpubNavigationHead({
    this.metadata = const [],
  });

  EpubNavigationHead copyWith({
    List<EpubNavigationMeta>? metadata,
  }) {
    return EpubNavigationHead(
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'metadata': metadata.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigationHead.fromMap(Map<String, dynamic> map) {
    return EpubNavigationHead(
      metadata: List<EpubNavigationMeta>.from(
        // ignore: unnecessary_lambdas
        map['metadata']?.map((e) => EpubNavigationMeta.fromMap(e)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationHead.fromJson(String source) =>
      EpubNavigationHead.fromMap(json.decode(source));

  @override
  String toString() => 'EpubNavigationHead(metadata: $metadata)';

  @override
  List<Object> get props => [metadata];

  @override
  String toXmlString() => '<$elementName>'
      '${metadata.map((meta) => meta.toXmlString())}'
      '</$elementName>';
}
