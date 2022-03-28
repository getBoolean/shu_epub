part of shu_epub.features.package.data;

class EpubTours extends EquatableXml {
  static const elementName = 'tours';

  final List<EpubSingleTour> items;

  /// Create an [EpubTours] object from the tours XmlElement.
  ///
  /// Throws [EpubException] if the tours element is not the root node
  factory EpubTours.fromXmlElement(XmlElement toursElement) {
    return EpubToursReader.fromXmlElement(toursElement);
  }

  /// Create an instance of [EpubTours] from the [String] representation
  /// of the tours element
  ///
  /// Throws [EpubException] if the string does not have the tours element
  factory EpubTours.fromXmlString(String toursString) {
    return EpubToursReader.fromXmlString(toursString);
  }

  /// Create an instance of [EpubTours] from the [Uint8List] data
  /// of the tours element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the tours element
  factory EpubTours.fromData(Uint8List toursData) {
    return EpubToursReader.fromData(toursData);
  }

  const EpubTours({
    this.items = const [],
  });

  EpubTours copyWith({
    List<EpubSingleTour>? items,
  }) {
    return EpubTours(
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((item) => item.toMap()),
    };
  }

  factory EpubTours.fromMap(Map<String, dynamic> map) {
    return EpubTours(
      items: List<EpubSingleTour>.from(
          // ignore: unnecessary_lambdas
          map['items']?.map((e) => EpubSingleTour.fromMap(e))),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubTours.fromJson(String source) =>
      EpubTours.fromMap(json.decode(source));

  @override
  String toString() => 'EpubTours(items: $items)';

  @override
  List<Object> get props => [items];

  @override
  String toXmlString() {
    return '<tours>'
          '${items.map((e) => e.toXmlString()).join('')}'
          '</tours>';
  }
}
