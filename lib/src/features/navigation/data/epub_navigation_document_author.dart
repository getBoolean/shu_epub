part of shu_epub.features.navigation.data;

/// The author of the document, immediately follows docTitle.
class EpubNavigationDocumentAuthor extends EquatableXml {
  static const elementName = 'docAuthor';

  final String? id;
  final String? language;
  final String? text;
  final EpubNavigationImage? image;

  /// Create an [EpubNavigationDocumentAuthor] object from the docAuthor XmlElement.
  ///
  /// Throws [EpubException] if the docAuthor element is not the root node
  factory EpubNavigationDocumentAuthor.fromXmlElement(
      XmlElement docAuthorElement) {
    return EpubNavigationDocumentAuthorReader.fromXmlElement(docAuthorElement);
  }

  factory EpubNavigationDocumentAuthor.fromXmlString(String docAuthorString) {
    return EpubNavigationDocumentAuthorReader.fromXmlString(docAuthorString);
  }

  /// Create an instance of [EpubNavigationDocumentAuthor] from the [Uint8List] data
  /// of the docAuthor element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the docAuthor element
  factory EpubNavigationDocumentAuthor.fromData(Uint8List docAuthorData) {
    return EpubNavigationDocumentAuthorReader.fromData(docAuthorData);
  }

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
    EpubNavigationImage? image,
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
          ? EpubNavigationImage.fromMap(map['image'])
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

  @override
  String toXmlString() => '<$elementName'
      '${id != null ? ' id="$id"' : ''}'
      '${language != null ? ' xml:lang="$language"' : ''}'
      '>'
      '${text != null ? '<text>$text</text>' : ''}'
      '${image != null ? image!.toXmlString() : ''}'
      '</$elementName>';
}
