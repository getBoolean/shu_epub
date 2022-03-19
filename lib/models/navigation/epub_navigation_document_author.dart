part of shu_epub.models;

/// The author of the document, immediately follows docTitle.
class EpubNavigationDocumentAuthor extends Equatable {
  final String? id;
  final String? language;
  final String? text;
  final EpubNavigationDocumentImage? image;

  const EpubNavigationDocumentAuthor({
    this.id,
    this.language,
    this.text,
    this.image,
  });

  factory EpubNavigationDocumentAuthor.zero() {
    return EpubNavigationDocumentAuthor();
  }

  EpubNavigationDocumentAuthor copyWith({
    String? id,
    String? language,
    String? text,
    EpubNavigationDocumentImage? image,
  }) {
    return EpubNavigationDocumentAuthor(
      id: id ?? this.id,
      language: language ?? this.language,
      text: text ?? this.text,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'language': language,
      'text': text,
      'image': image?.toMap(),
    };
  }

  factory EpubNavigationDocumentAuthor.fromMap(Map<String, dynamic> map) {
    return EpubNavigationDocumentAuthor(
      id: map['id'],
      language: map['language'],
      text: map['text'],
      image: map['image'] != null
          ? EpubNavigationDocumentImage.fromMap(map['image'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationDocumentAuthor.fromJson(String source) =>
      EpubNavigationDocumentAuthor.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubNavigationDocumentAuthor(id: $id, language: $language, text: $text, image: $image)';
  }

  @override
  List<Object> get props {
    return [
      id ?? 'no id attribute',
      language ?? 'no lang attribute',
      text ?? 'no text attribute',
      image ?? 'no image attribute',
    ];
  }
}
