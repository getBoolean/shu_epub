part of shu_epub.features.package.data;

class EpubGuideItem extends Equatable {
  static const elementName = 'reference';

  /// The required type attribute describes the publication component
  /// referenced by the href attribute. The values for the type
  /// attributes must be selected from the list defined below
  /// when applicable ([EpubGuideReferenceType]). Other types may be
  /// used when none of the predefined types are applicable; their
  /// names must begin with the string `other.`. The value for the
  /// type attribute is case-sensitive.
  ///
  /// List of accepted types: [http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.6](http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.6)
  final String? type;
  final String? title;

  /// Each reference must have an href attribute referring to an OPS Content
  /// Document included in the manifest, and which may include a fragment
  /// identifier as defined in section 4.1 of RFC 2396
  /// (see http://www.ietf.org/rfc/rfc2396.txt). Reading Systems may use
  /// the bounds of the referenced element to determine the scope of the
  /// reference. If a fragment identifier is not used, the scope is
  /// considered to be the entire document. This specification does not
  /// require Reading Systems to mark or otherwise identify the entire
  /// scope of a referenced element.
  final String? href;

  /// Create an [EpubGuideItem] object from the reference XmlElement.
  ///
  /// Throws [EpubException] if the reference element is not the root node
  factory EpubGuideItem.fromXmlElement(XmlElement referenceElement) {
    return EpubGuideItemReader.fromXmlElement(referenceElement);
  }

  /// Create an instance of [EpubGuideItem] from the [String] representation
  /// of the reference element
  ///
  /// Throws [EpubException] if the string does not have the reference element
  factory EpubGuideItem.fromString(String referenceString) {
    return EpubGuideItemReader.fromString(referenceString);
  }

  /// Create an instance of [EpubGuideItem] from the [Uint8List] data
  /// of the reference element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the reference element
  factory EpubGuideItem.fromData(Uint8List referenceData) {
    return EpubGuideItemReader.fromData(referenceData);
  }

  const EpubGuideItem({
    this.type,
    this.title,
    this.href,
  });

  EpubGuideItem copyWith({
    String? type,
    String? title,
    String? href,
  }) {
    return EpubGuideItem(
      type: type ?? this.type,
      title: title ?? this.title,
      href: href ?? this.href,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'title': title,
      'href': href,
    };
  }

  factory EpubGuideItem.fromMap(Map<String, dynamic> map) {
    return EpubGuideItem(
      type: map['type'],
      title: map['title'],
      href: map['href'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubGuideItem.fromJson(String source) =>
      EpubGuideItem.fromMap(json.decode(source));

  @override
  String toString() => 'EpubGuideItem(type: $type, title: $title, href: $href)';

  @override
  List<Object> get props =>
      [type ?? 'no type', title ?? 'no title', href ?? 'no href'];
}
