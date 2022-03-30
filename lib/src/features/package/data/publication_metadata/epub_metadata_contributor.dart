part of shu_epub.features.package.data;

class EpubMetadataContributor extends EquatableXml {
  static const elementName = 'dc:contributor';

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
  factory EpubMetadataContributor.fromXmlElement(XmlElement element) {
    return EpubMetadataContributerReader.fromXmlElement(element);
  }

  /// Create an instance of [EpubMetadataContributer] from the [String] representation
  /// of the contributor or author element
  ///
  /// Throws [EpubException] if the string does not have the contributor or author element
  factory EpubMetadataContributor.fromXmlString(String content) {
    return EpubMetadataContributerReader.fromXmlString(content);
  }

  /// Create an instance of [EpubMetadataContributer] from the [Uint8List] data
  /// of the contributor or author element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the contributor or author element
  factory EpubMetadataContributor.fromData(Uint8List data) {
    return EpubMetadataContributerReader.fromData(data);
  }

  const EpubMetadataContributor({
    this.name = '',
    this.fileAs,
    this.role,
  });

  EpubMetadataContributor copyWith({
    String? name,
    String? fileAs,
    String? role,
  }) {
    return EpubMetadataContributor(
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

  factory EpubMetadataContributor.fromMap(Map<String, dynamic> map) {
    return EpubMetadataContributor(
      name: map['name'],
      fileAs: map['fileAs'],
      role: map['role'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubMetadataContributor.fromJson(String source) =>
      EpubMetadataContributor.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubMetadataContributor(name: $name, fileAs: $fileAs, role: $role)';

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
