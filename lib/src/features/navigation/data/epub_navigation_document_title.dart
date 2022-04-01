part of shu_epub.features.navigation.data;

@Immutable()
class EpubNavigationDocumentTitle extends EquatableXml {
  static const elementName = 'docTitle';

  final String? id;
  final String? language;
  final String? text;
  final EpubNavigationImage? image;

  /// Create an [EpubNavigationDocumentTitle] object from the docTitle XmlElement.
  ///
  /// Throws [EpubException] if the docTitle element is not the root node
  factory EpubNavigationDocumentTitle.fromXmlElement(
      XmlElement docTitleElement) {
    return EpubNavigationDocumentTitleReader.fromXmlElement(docTitleElement);
  }

  factory EpubNavigationDocumentTitle.fromXmlString(String docTitleString) {
    return EpubNavigationDocumentTitleReader.fromXmlString(docTitleString);
  }

  /// Create an instance of [EpubNavigationDocumentTitle] from the [Uint8List] data
  /// of the docTitle element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the docTitle element
  factory EpubNavigationDocumentTitle.fromData(Uint8List docTitleData) {
    return EpubNavigationDocumentTitleReader.fromData(docTitleData);
  }

  const EpubNavigationDocumentTitle({
    this.id,
    this.language,
    this.text,
    this.image,
  });

  factory EpubNavigationDocumentTitle.zero() {
    return EpubNavigationDocumentTitle();
  }

  EpubNavigationDocumentTitle copyWith({
    String? id,
    String? language,
    String? text,
    EpubNavigationImage? image,
  }) {
    return EpubNavigationDocumentTitle(
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

  factory EpubNavigationDocumentTitle.fromMap(Map<String, dynamic> map) {
    return EpubNavigationDocumentTitle(
      id: map['id'],
      language: map['language'],
      text: map['text'],
      image: map['image'] != null
          ? EpubNavigationImage.fromMap(map['image'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationDocumentTitle.fromJson(String source) =>
      EpubNavigationDocumentTitle.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubNavigationDocumentTitle(id: $id, language: $language, text: $text, image: $image)';
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
