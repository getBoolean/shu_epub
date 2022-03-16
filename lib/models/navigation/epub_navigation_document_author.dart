part of shu_epub.models;

class EpubNavigationDocumentAuthor extends Equatable {
  final List<String> authors;
  final List<EpubNavigationDocumentImage> images;

  const EpubNavigationDocumentAuthor({
    required this.authors,
    required this.images,
  });

  factory EpubNavigationDocumentAuthor.zero() {
    return EpubNavigationDocumentAuthor(authors: [], images: []);
  }

  EpubNavigationDocumentAuthor copyWith({
    List<String>? authors,
    List<EpubNavigationDocumentImage>? images,
  }) {
    return EpubNavigationDocumentAuthor(
      authors: authors ?? this.authors,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'authors': authors,
      'images': images.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigationDocumentAuthor.fromMap(Map<String, dynamic> map) {
    return EpubNavigationDocumentAuthor(
      authors: List<String>.from(map['authors']),
      images: List<EpubNavigationDocumentImage>.from(
          map['images']?.map((x) => EpubNavigationDocumentImage.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationDocumentAuthor.fromJson(String source) =>
      EpubNavigationDocumentAuthor.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubNavigationDocumentAuthor(authors: $authors, images: $images)';

  @override
  List<Object> get props => [authors, images];
}
