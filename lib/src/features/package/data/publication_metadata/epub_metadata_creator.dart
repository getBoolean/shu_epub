part of shu_epub.features.package.data;

class EpubMetadataCreator extends EquatableXml {
  static const elementName = 'dc:creator';

  final String name;

  /// Used to specify a normalized form of the name, suitable for machine processing.
  final String? fileAs;

  /// Allowed values are specified by the [MARC relator code list](http://www.loc.gov/marc/relators/)
  ///
  /// If a value is not defined on that list, it must begin with `"oth"`
  final String? role;

  /// Create an [EpubMetadataContributer] object from the contributor or author XmlElement.
  ///
  /// Throws [EpubException] if the contributor or author element is not the root node
  factory EpubMetadataCreator.fromXmlElement(XmlElement element) {
    return EpubMetadataCreatorReader.fromXmlElement(element);
  }

  /// Create an instance of [EpubMetadataContributer] from the [String] representation
  /// of the contributor or author element
  ///
  /// Throws [EpubException] if the string does not have the contributor or author element
  factory EpubMetadataCreator.fromXmlString(String content) {
    return EpubMetadataCreatorReader.fromXmlString(content);
  }

  /// Create an instance of [EpubMetadataContributer] from the [Uint8List] data
  /// of the contributor or author element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the contributor or author element
  factory EpubMetadataCreator.fromData(Uint8List data) {
    return EpubMetadataCreatorReader.fromData(data);
  }

  const EpubMetadataCreator({
    this.name = '',
    this.fileAs,
    this.role,
  });

  EpubMetadataCreator copyWith({
    String? name,
    String? fileAs,
    String? role,
  }) {
    return EpubMetadataCreator(
      name: name ?? this.name,
      fileAs: fileAs ?? this.fileAs,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'fileAs': fileAs,
      'role': role,
    };
  }

  factory EpubMetadataCreator.fromMap(Map<String, dynamic> map) {
    return EpubMetadataCreator(
      name: map['name'],
      fileAs: map['fileAs'],
      role: map['role'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubMetadataCreator.fromJson(String source) =>
      EpubMetadataCreator.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubMetadataCreator(name: $name, fileAs: $fileAs, role: $role)';

  @override
  List<Object> get props => [
        name,
        fileAs ?? 'no normalized version given',
        role ?? 'no role specified'
      ];

  @override
  String toXmlString() => '<$elementName'
      '${fileAs != null ? ' file-as="$fileAs"' : ''}'
      '${role != null ? ' role="$role"' : ''}'
      '>'
      '${'<text>"$name"<value/>'}'
      '<$elementName/>';
}
