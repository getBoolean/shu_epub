part of shu_epub.features.navigation.data;

/// Navigation Information - Contains an informative comment about a
/// [EpubNavigationMap], [EpubNavigationPageList], or [EpubNavigationList]
/// in various media for presentation to the user.
@Immutable()
class EpubNavigationInfo extends EquatableXml {
  static const elementName = 'navInfo';

  final String? text;
  final String? language;
  final EpubNavigationImage? image;

  /// Create an [EpubNavigationInfo] object from the navInfo XmlElement.
  ///
  /// Throws [EpubException] if the navInfo element is not the root node
  factory EpubNavigationInfo.fromXmlElement(XmlElement navInfoElement) {
    return EpubNavigationInfoReader.fromXmlElement(navInfoElement);
  }

  /// Create an instance of [EpubNavigationInfo] from the [String] representation
  /// of the navInfo element
  ///
  /// Throws [EpubException] if the string does not have the navInfo element
  factory EpubNavigationInfo.fromXmlString(String navInfoString) {
    return EpubNavigationInfoReader.fromXmlString(navInfoString);
  }

  /// Create an instance of [EpubNavigationInfo] from the [Uint8List] data
  /// of the navInfo element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navInfo element
  factory EpubNavigationInfo.fromData(Uint8List navInfoData) {
    return EpubNavigationInfoReader.fromData(navInfoData);
  }

  const EpubNavigationInfo({
    this.text,
    this.language,
    this.image,
  });

  EpubNavigationInfo copyWith({
    String? text,
    String? language,
    EpubNavigationImage? image,
  }) {
    return EpubNavigationInfo(
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

  factory EpubNavigationInfo.fromMap(Map<String, dynamic> map) {
    return EpubNavigationInfo(
      text: map['text'],
      language: map['language'],
      image: map['image'] != null
          ? EpubNavigationImage.fromMap(map['image'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationInfo.fromJson(String source) =>
      EpubNavigationInfo.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubNavigationInfo(text: $text, language: $language, image: $image)';

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
