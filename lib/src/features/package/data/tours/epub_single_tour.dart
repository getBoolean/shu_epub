part of shu_epub.features.package.data;

class EpubSingleTour extends EquatableXml {
  static const elementName = 'tour';

  final List<EpubTourSite> sites;
  final String? id;
  final String? title;

  /// Create an [EpubSingleTour] object from the tour XmlElement.
  ///
  /// Throws [EpubException] if the tour element is not the root node
  factory EpubSingleTour.fromXmlElement(XmlElement tourElement) {
    return EpubSingleTourReader.fromXmlElement(tourElement);
  }

  /// Create an instance of [EpubSingleTour] from the [String] representation
  /// of the tour element
  ///
  /// Throws [EpubException] if the string does not have the tour element
  factory EpubSingleTour.fromXmlString(String tourString) {
    return EpubSingleTourReader.fromXmlString(tourString);
  }

  /// Create an instance of [EpubSingleTour] from the [Uint8List] data
  /// of the tour element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the tour element
  factory EpubSingleTour.fromData(Uint8List tourData) {
    return EpubSingleTourReader.fromData(tourData);
  }

  const EpubSingleTour({
    this.sites = const [],
    this.id,
    this.title,
  });

  EpubSingleTour copyWith({
    List<EpubTourSite>? sites,
    String? id,
    String? title,
  }) {
    return EpubSingleTour(
      sites: sites ?? this.sites,
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sites': sites.map((x) => x.toMap()).toList(),
      'id': id,
      'title': title,
    };
  }

  factory EpubSingleTour.fromMap(Map<String, dynamic> map) {
    return EpubSingleTour(
      // ignore: unnecessary_lambdas
      sites: List<EpubTourSite>.from(map['sites']?.map((x) => EpubTourSite.fromMap(x))),
      id: map['id'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubSingleTour.fromJson(String source) =>
      EpubSingleTour.fromMap(json.decode(source));

  @override
  String toString() => 'EpubSingleTour(sites: $sites, id: $id, title: $title)';

  @override
  List<Object> get props => [sites, id ?? 'no id', title ?? 'no title'];

  @override
  String toXmlString() {
    return '<tour'
        '${id != null ? ' id="$id"' : ''}'
        '${title != null ? ' title="$title"' : ''}'
        '>'
        '${sites.map((e) => e.toXmlString()).join('')}'
        '</tour>';
  }
}
