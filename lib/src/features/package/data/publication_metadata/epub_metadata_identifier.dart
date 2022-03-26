part of shu_epub.features.package.data;

class EpubMetadataIdentifier extends Equatable {
  static const elementName = 'dc:identifier';

  final String value;

  final String? id;

  bool get isPrimary => id != null;

  /// The scheme attribute names the system or authority that generated or
  /// assigned the text contained within the identifier element, for example
  /// "ISBN" or "DOI." The values of the scheme attribute are case sensitive
  /// only when the particular scheme requires it.
  ///
  /// The EPUB 2.1 specification does not standardize or endorse any particular
  /// publication identifier scheme. Specific uses of URLs or ISBNs are not
  /// yet addressed by this specification. Identifier schemes are not currently
  /// defined by Dublin Core.
  final String? scheme;

  /// Create an [EpubMetadataIdentifier] object from the dc:identifier XmlElement.
  ///
  /// Throws [EpubException] if the dc:identifier element is not the root node
  factory EpubMetadataIdentifier.fromXmlElement(
      XmlElement dcidentifierElement) {
    return EpubMetadataIdentifierReader.fromXmlElement(dcidentifierElement);
  }

  /// Create an instance of [EpubMetadataIdentifier] from the [String] representation
  /// of the dc:identifier element
  ///
  /// Throws [EpubException] if the string does not have the dc:identifier element
  factory EpubMetadataIdentifier.fromString(String dcidentifierString) {
    return EpubMetadataIdentifierReader.fromString(dcidentifierString);
  }

  /// Create an instance of [EpubMetadataIdentifier] from the [Uint8List] data
  /// of the dc:identifier element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the dc:identifier element
  factory EpubMetadataIdentifier.fromData(Uint8List dcidentifierData) {
    return EpubMetadataIdentifierReader.fromData(dcidentifierData);
  }

  const EpubMetadataIdentifier({
    this.value = '',
    this.id,
    this.scheme,
  });

  EpubMetadataIdentifier copyWith({
    String? value,
    String? id,
    String? scheme,
  }) {
    return EpubMetadataIdentifier(
      value: value ?? this.value,
      id: id ?? this.id,
      scheme: scheme ?? this.scheme,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'id': id,
      'scheme': scheme,
    };
  }

  factory EpubMetadataIdentifier.fromMap(Map<String, dynamic> map) {
    return EpubMetadataIdentifier(
      value: map['value'],
      id: map['id'],
      scheme: map['scheme'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubMetadataIdentifier.fromJson(String source) =>
      EpubMetadataIdentifier.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubMetadataIdentifier(value: $value, id: $id, scheme: $scheme)';

  @override
  List<Object> get props => [
        value,
        id ?? 'no id given',
        scheme ?? 'no scheme given',
      ];
}
