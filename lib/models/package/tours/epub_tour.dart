part of shu_epub.models;

class EpubTour extends Equatable {
  final List<EpubTourSite> sites;

  const EpubTour({
    required this.sites,
  });

  EpubTour copyWith({
    List<EpubTourSite>? sites,
  }) {
    return EpubTour(
      sites: sites ?? this.sites,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sites': sites.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubTour.fromMap(Map<String, dynamic> map) {
    return EpubTour(
      sites: List<EpubTourSite>.from(
          map['sites']?.map((x) => EpubTourSite.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubTour.fromJson(String source) =>
      EpubTour.fromMap(json.decode(source));

  @override
  String toString() => 'EpubTour(sites: $sites)';

  @override
  List<Object> get props => [sites];
}
