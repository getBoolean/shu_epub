part of shu_epub.features.package.data;

/// Deprecated in EPUB 3.0 in favor of EpubLandmarks // TODO
@Immutable()
class EpubGuide extends EquatableXml {
  static const elementName = 'guide';

  final List<EpubGuideItem> items;

  /// Create an [EpubGuide] object from the guide XmlElement.
  ///
  /// Throws [EpubException] if the guide element is not the root node
  factory EpubGuide.fromXmlElement(XmlElement guideElement) {
    return EpubGuideReader.fromXmlElement(guideElement);
  }

  /// Create an instance of [EpubGuide] from the [String] representation
  /// of the guide element
  ///
  /// Throws [EpubException] if the string does not have the guide element
  factory EpubGuide.fromXmlString(String guideString) {
    return EpubGuideReader.fromXmlString(guideString);
  }

  /// Create an instance of [EpubGuide] from the [Uint8List] data
  /// of the guide element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the guide element
  factory EpubGuide.fromData(Uint8List guideData) {
    return EpubGuideReader.fromData(guideData);
  }

  const EpubGuide({
    this.items = const [],
  });

  EpubGuide copyWith({
    List<EpubGuideItem>? items,
  }) {
    return EpubGuide(
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((item) => item.toMap()).toList(),
    };
  }

  factory EpubGuide.fromMap(Map<String, dynamic> map) {
    return EpubGuide(
      items: List<EpubGuideItem>.from(
        // ignore: unnecessary_lambdas
        map['items']?.map((e) => EpubGuideItem.fromMap(e)),
      ),
    );
  }

  String toJson() {
    final Map<String, dynamic> mapped = toMap();
    return json.encode(mapped);
  }

  factory EpubGuide.fromJson(String source) =>
      EpubGuide.fromMap(json.decode(source));

  @override
  String toString() => 'EpubGuide(items: $items)';

  @override
  List<Object> get props => [items];

  @override
  String toXmlString() => '<$elementName>'
      '${items.map((item) => item.toXmlString()).join('')}'
      '</$elementName>';
}
