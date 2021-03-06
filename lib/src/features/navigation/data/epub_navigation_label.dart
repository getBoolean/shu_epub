part of shu_epub.features.navigation.data;

/// Navigation Label - Contains a description of a given
/// [EpubNavigationMap], [EpubNavigationPoint], [EpubNavigationList], or
/// [EpubNavigationTarget] in various media for presentation to the user.
///
/// Can be repeated so descriptions can be provided in multiple languages.
@Immutable()
class EpubNavigationLabel extends EquatableXml {
  static const elementName = 'navLabel';

  final String? text;
  final String? language;
  final EpubNavigationImage? image;

  /// Create an [EpubNavigationLabel] object from the navLabel XmlElement.
  ///
  /// Throws [EpubException] if the navLabel element is not the root node
  factory EpubNavigationLabel.fromXmlElement(XmlElement navLabelElement) {
    return EpubNavigationLabelReader.fromXmlElement(navLabelElement);
  }

  /// Create an instance of [EpubNavigationLabel] from the [String] representation
  /// of the navLabel element
  ///
  /// Throws [EpubException] if the string does not have the navLabel element
  factory EpubNavigationLabel.fromXmlString(String navLabelString) {
    return EpubNavigationLabelReader.fromXmlString(navLabelString);
  }

  /// Create an instance of [EpubNavigationLabel] from the [Uint8List] data
  /// of the navLabel element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navLabel element
  factory EpubNavigationLabel.fromData(Uint8List navLabelData) {
    return EpubNavigationLabelReader.fromData(navLabelData);
  }

  const EpubNavigationLabel({
    this.text,
    this.language,
    this.image,
  });

  EpubNavigationLabel copyWith({
    String? text,
    String? language,
    EpubNavigationImage? image,
  }) {
    return EpubNavigationLabel(
      text: text ?? this.text,
      language: language ?? this.language,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'language': language,
      'image': image?.toMap(),
    };
  }

  factory EpubNavigationLabel.fromMap(Map<String, dynamic> map) {
    return EpubNavigationLabel(
      text: map['text'],
      language: map['language'],
      image: map['image'] != null
          ? EpubNavigationImage.fromMap(map['image'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationLabel.fromJson(String source) =>
      EpubNavigationLabel.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubNavigationLabel(text: $text, language: $language, image: $image)';

  @override
  List<Object> get props =>
      [text ?? 'no text', language ?? 'no language', image ?? 'no image'];

  @override
  String toXmlString() => '<$elementName'
      '${language != null ? ' xml:lang="$language"' : ''}'
      '>'
      '${text != null ? '<text>$text</text>' : ''}'
      '${image != null ? image!.toXmlString() : ''}'
      '</$elementName>';
}
