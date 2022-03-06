part of shu_epub.models;

class EpubMetadataIdentifier extends Equatable {
  final String? id;

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
  EpubMetadataIdentifier({
    this.id,
    this.scheme,
  });

  EpubMetadataIdentifier copyWith({
    String? id,
    String? scheme,
  }) {
    return EpubMetadataIdentifier(
      id: id ?? this.id,
      scheme: scheme ?? this.scheme,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'scheme': scheme,
    };
  }

  factory EpubMetadataIdentifier.fromMap(Map<String, dynamic> map) {
    return EpubMetadataIdentifier(
      id: map['id'],
      scheme: map['scheme'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubMetadataIdentifier.fromJson(String source) =>
      EpubMetadataIdentifier.fromMap(json.decode(source));

  @override
  String toString() => 'EpubMetadataIdentifier(id: $id, scheme: $scheme)';

  @override
  List<Object> get props => [id ?? 'no id', scheme ?? 'no scheme specified'];
}
