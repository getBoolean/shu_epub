part of shu_epub.models;

class EpubNavigationDocumentTitle extends Equatable {
  final String title;
  final List<EpubNavigationDocumentImage> images;
  
  const EpubNavigationDocumentTitle({
    required this.title,
    required this.images,
  });

  factory EpubNavigationDocumentTitle.zero() {
    return EpubNavigationDocumentTitle(title: '', images: []);
  }

  EpubNavigationDocumentTitle copyWith({
    String? title,
    List<EpubNavigationDocumentImage>? images,
  }) {
    return EpubNavigationDocumentTitle(
      title: title ?? this.title,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'images': images.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigationDocumentTitle.fromMap(Map<String, dynamic> map) {
    return EpubNavigationDocumentTitle(
      title: map['title'] ?? '',
      images: List<EpubNavigationDocumentImage>.from(map['images']?.map((x) => EpubNavigationDocumentImage.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationDocumentTitle.fromJson(String source) => EpubNavigationDocumentTitle.fromMap(json.decode(source));

  @override
  String toString() => 'EpubNavigationDocumentTitle(titles: $title, images: $images)';

  @override
  List<Object> get props => [title, images];
}
