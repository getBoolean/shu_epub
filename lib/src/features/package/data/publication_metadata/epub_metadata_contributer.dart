part of shu_epub.features.package.data;

class EpubMetadataContributer extends Equatable {
  static const contributorElementName = 'dc:contributor';
  static const creatorElementName = 'dc:author';

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
  factory EpubMetadataContributer.fromXmlElement(XmlElement element) {
    return EpubMetadataContributerReader.fromXmlElement(element);
  }

  /// Create an instance of [EpubMetadataContributer] from the [String] representation
  /// of the contributor or author element
  ///
  /// Throws [EpubException] if the string does not have the contributor or author element
  factory EpubMetadataContributer.fromString(String content) {
    return EpubMetadataContributerReader.fromString(content);
  }

  /// Create an instance of [EpubMetadataContributer] from the [Uint8List] data
  /// of the contributor or author element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the contributor or author element
  factory EpubMetadataContributer.fromData(Uint8List data) {
    return EpubMetadataContributerReader.fromData(data);
  }

  const EpubMetadataContributer({
    this.name = '',
    this.fileAs,
    this.role,
  });

  EpubMetadataContributer copyWith({
    String? name,
    String? fileAs,
    String? role,
  }) {
    return EpubMetadataContributer(
      name: name ?? this.name,
      fileAs: fileAs ?? this.fileAs,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'file-as': fileAs,
      'role': role,
    };
  }

  factory EpubMetadataContributer.fromMap(Map<String, dynamic> map) {
    return EpubMetadataContributer(
      name: map['name'],
      fileAs: map['file-as'],
      role: map['role'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubMetadataContributer.fromJson(String source) =>
      EpubMetadataContributer.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubMetadataContributer(name: $name, fileAs: $fileAs, role: $role)';

  @override
  List<Object> get props => [
        name,
        fileAs ?? 'no normalized version given',
        role ?? 'no role specified'
      ];
}
