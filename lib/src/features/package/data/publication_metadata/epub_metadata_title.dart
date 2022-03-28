part of shu_epub.features.package.data;

class EpubMetadataTitle extends Equatable {
  static const elementName = 'dc:title';

  final String text;
  final String? language;

  /// Create an [EpubMetadataTitle] object from the dc:title XmlElement.
  ///
  /// Throws [EpubException] if the dc:title element is not the root node
  factory EpubMetadataTitle.fromXmlElement(XmlElement dctitleElement) {
    return EpubMetadataTitleReader.fromXmlElement(dctitleElement);
  }

  /// Create an instance of [EpubMetadataTitle] from the [String] representation
  /// of the dc:title element
  ///
  /// Throws [EpubException] if the string does not have the dctitle element
  factory EpubMetadataTitle.fromXmlString(String dctitleString) {
    return EpubMetadataTitleReader.fromXmlString(dctitleString);
  }

  /// Create an instance of [EpubMetadataTitle] from the [Uint8List] data
  /// of the dc:title element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the dctitle element
  factory EpubMetadataTitle.fromData(Uint8List dctitleData) {
    return EpubMetadataTitleReader.fromData(dctitleData);
  }

  const EpubMetadataTitle({
    this.text = '',
    this.language,
  });

  EpubMetadataTitle copyWith({
    String? text,
    String? language,
  }) {
    return EpubMetadataTitle(
      text: text ?? this.text,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'language': language,
    };
  }

  factory EpubMetadataTitle.fromMap(Map<String, dynamic> map) {
    return EpubMetadataTitle(
      text: map['text'],
      language: map['language'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubMetadataTitle.fromJson(String source) =>
      EpubMetadataTitle.fromMap(json.decode(source));

  @override
  String toString() => 'EpubMetadataTitle(text: $text, language: $language)';

  @override
  List<Object> get props => [text, language ?? 'no language'];
}
