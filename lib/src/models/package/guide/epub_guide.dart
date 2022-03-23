part of shu_epub.models;

class EpubGuide extends Equatable {
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
  factory EpubGuide.fromString(String guideString) {
    return EpubGuideReader.fromString(guideString);
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
      'items': items.map((item) => item.toMap()),
    };
  }

  factory EpubGuide.zero() {
    return EpubGuide(items: []);
  }

  factory EpubGuide.fromMap(Map<String, dynamic> map) {
    return EpubGuide(
      items: List<EpubGuideItem>.from(map['items']?.map(EpubGuideItem.fromMap)),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubGuide.fromJson(String source) =>
      EpubGuide.fromMap(json.decode(source));

  @override
  String toString() => 'EpubGuide(items: $items)';

  @override
  List<Object> get props => [items];
}
