part of shu_epub.models;

class EpubSingleTour extends Equatable {
  final List<EpubTourSite> sites;

  const EpubSingleTour({
    required this.sites,
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
      sites: List<EpubTourSite>.from(map['sites']?.map(EpubTourSite.fromMap)),
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
