part of shu_epub.models;

class EpubNavigationDocumentAuthor extends Equatable {
  final String? id;
  final List<String> authors;
  final List<EpubNavigationDocumentImage> images;

  const EpubNavigationDocumentAuthor({
    this.id,
    required this.authors,
    required this.images,
  });

  factory EpubNavigationDocumentAuthor.zero() {
    return EpubNavigationDocumentAuthor(authors: [], images: []);
  }

  EpubNavigationDocumentAuthor copyWith({
    String? id,
    List<String>? authors,
    List<EpubNavigationDocumentImage>? images,
  }) {
    return EpubNavigationDocumentAuthor(
      id: id ?? this.id,
      authors: authors ?? this.authors,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'authors': authors,
      'images': images.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigationDocumentAuthor.fromMap(Map<String, dynamic> map) {
    return EpubNavigationDocumentAuthor(
      id: map['id'],
      authors: List<String>.from(map['authors'] ?? const []),
      images: List<EpubNavigationDocumentImage>.from(
          map['images']?.map((x) => EpubNavigationDocumentImage.fromMap(x)) ??
              const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationDocumentAuthor.fromJson(String source) =>
      EpubNavigationDocumentAuthor.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubNavigationDocumentAuthor(id: $id, authors: $authors, images: $images)';

  @override
  List<Object> get props => [id ?? 'no id', authors, images];
}
