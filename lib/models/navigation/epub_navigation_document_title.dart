part of shu_epub.models;

class EpubNavigationDocumentTitle extends Equatable {
  final List<String> titles;
  final List<EpubNavigationDocumentImage> images;
  
  const EpubNavigationDocumentTitle({
    required this.titles,
    required this.images,
  });

  factory EpubNavigationDocumentTitle.zero() {
    return EpubNavigationDocumentTitle(titles: [], images: []);
  }

  EpubNavigationDocumentTitle copyWith({
    List<String>? titles,
    List<EpubNavigationDocumentImage>? images,
  }) {
    return EpubNavigationDocumentTitle(
      titles: titles ?? this.titles,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titles': titles,
      'images': images.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigationDocumentTitle.fromMap(Map<String, dynamic> map) {
    return EpubNavigationDocumentTitle(
      titles: List<String>.from(map['titles']),
      images: List<EpubNavigationDocumentImage>.from(map['images']?.map((x) => EpubNavigationDocumentImage.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationDocumentTitle.fromJson(String source) => EpubNavigationDocumentTitle.fromMap(json.decode(source));

  @override
  String toString() => 'EpubNavigationDocumentTitle(titles: $titles, images: $images)';

  @override
  List<Object> get props => [titles, images];
}
