part of shu_epub.features.package.data;

class EpubMetadataContributer extends Equatable {
  final String name;

  /// Used to specify a normalized form of the name, suitable for machine processing.
  final String? fileAs;

  /// Allowed values are specified by the [MARC relator code list](http://www.loc.gov/marc/relators/)
  ///
  /// If a value is not defined on that list, it must begin with `"oth"`
  final String? role;

  const EpubMetadataContributer({
    required this.name,
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
      'fileAs': fileAs,
      'role': role,
    };
  }

  factory EpubMetadataContributer.fromMap(Map<String, dynamic> map) {
    return EpubMetadataContributer(
      name: map['name'] ?? '',
      fileAs: map['fileAs'],
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
