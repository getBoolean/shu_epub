part of shu_epub.models;

class EpubGuideReference extends Equatable {
  /// The required type attribute describes the publication component
  /// referenced by the href attribute. The values for the type
  /// attributes must be selected from the list defined below
  /// when applicable ([EpubGuideReferenceType]). Other types may be
  /// used when none of the predefined types are applicable; their
  /// names must begin with the string `other.`. The value for the
  /// type attribute is case-sensitive.
  ///
  /// List of accepted types: [http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.6](http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.6)
  final String type;
  final String title;

  /// Each reference must have an href attribute referring to an OPS Content
  /// Document included in the manifest, and which may include a fragment
  /// identifier as defined in section 4.1 of RFC 2396
  /// (see http://www.ietf.org/rfc/rfc2396.txt). Reading Systems may use
  /// the bounds of the referenced element to determine the scope of the
  /// reference. If a fragment identifier is not used, the scope is
  /// considered to be the entire document. This specification does not
  /// require Reading Systems to mark or otherwise identify the entire
  /// scope of a referenced element.
  final String htmlReference;

  const EpubGuideReference({
    required this.type,
    required this.title,
    required this.htmlReference,
  });

  EpubGuideReference copyWith({
    String? type,
    String? title,
    String? htmlReference,
  }) {
    return EpubGuideReference(
      type: type ?? this.type,
      title: title ?? this.title,
      htmlReference: htmlReference ?? this.htmlReference,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'title': title,
      'htmlReference': htmlReference,
    };
  }

  factory EpubGuideReference.fromMap(Map<String, dynamic> map) {
    return EpubGuideReference(
      type: map['type'] ?? '',
      title: map['title'] ?? '',
      htmlReference: map['htmlReference'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubGuideReference.fromJson(String source) =>
      EpubGuideReference.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubGuideReference(type: $type, title: $title, htmlReference: $htmlReference)';

  @override
  List<Object> get props => [type, title, htmlReference];
}
