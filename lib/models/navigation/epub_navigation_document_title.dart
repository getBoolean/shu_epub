part of shu_epub.models;

class EpubNavigationDocumentTitle extends Equatable {
  final String? id;
  final List<String> titles;
  final List<EpubNavigationDocumentImage> images;

  const EpubNavigationDocumentTitle({
    this.id,
    required this.titles,
    required this.images,
  });

  factory EpubNavigationDocumentTitle.zero() {
    return EpubNavigationDocumentTitle(titles: [], images: []);
  }

  EpubNavigationDocumentTitle copyWith({
    String? id,
    List<String>? titles,
    List<EpubNavigationDocumentImage>? images,
  }) {
    return EpubNavigationDocumentTitle(
      id: id ?? this.id,
      titles: titles ?? this.titles,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titles': titles,
      'images': images.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigationDocumentTitle.fromMap(Map<String, dynamic> map) {
    return EpubNavigationDocumentTitle(
      id: map['id'],
      titles: List<String>.from(map['titles'] ?? const []),
      images: List<EpubNavigationDocumentImage>.from(map['images']?.map((x) => EpubNavigationDocumentImage.fromMap(x)) ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationDocumentTitle.fromJson(String source) =>
      EpubNavigationDocumentTitle.fromMap(json.decode(source));

  @override
  String toString() => 'EpubNavigationDocumentTitle(id: $id, titles: $titles, images: $images)';

  @override
  List<Object> get props => [id ?? 'no id', titles, images];
}
