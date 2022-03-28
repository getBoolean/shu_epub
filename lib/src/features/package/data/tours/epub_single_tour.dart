part of shu_epub.features.package.data;

class EpubSingleTour extends Equatable {
  static const elementName = 'tour';

  final List<EpubTourSite> sites;

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
  factory EpubSingleTour.fromString(String tourString) {
    return EpubSingleTourReader.fromString(tourString);
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
  });

  EpubSingleTour copyWith({
    List<EpubTourSite>? sites,
  }) {
    return EpubSingleTour(
      sites: sites ?? this.sites,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sites': sites.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubSingleTour.fromMap(Map<String, dynamic> map) {
    return EpubSingleTour(
      // ignore: unnecessary_lambdas
      sites: List<EpubTourSite>.from(map['sites']?.map((e) => EpubTourSite.fromMap(e))),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubSingleTour.fromJson(String source) =>
      EpubSingleTour.fromMap(json.decode(source));

  @override
  String toString() => 'EpubTour(sites: $sites)';

  @override
  List<Object> get props => [sites];
}
