part of epub_master.models;

class PackageIdentity extends Equatable {
  final String epubVersion;

  final String uniqueIdentifier;

  final String? id;

  factory PackageIdentity.zero() {
    return PackageIdentity(
      epubVersion: 'unknown',
      uniqueIdentifier: 'unknown',
    );
  }

  // GENERATED DO NOT MODOFY

  PackageIdentity({
    required this.epubVersion,
    required this.uniqueIdentifier,
    this.id,
  });

  PackageIdentity copyWith({
    String? epubVersion,
    String? uniqueIdentifier,
    String? id,
  }) {
    return PackageIdentity(
      epubVersion: epubVersion ?? this.epubVersion,
      uniqueIdentifier: uniqueIdentifier ?? this.uniqueIdentifier,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'epubVersion': epubVersion,
      'uniqueIdentifier': uniqueIdentifier,
      'id': id,
    };
  }

  factory PackageIdentity.fromMap(Map<String, dynamic> map) {
    return PackageIdentity(
      epubVersion: map['epubVersion'] ?? '',
      uniqueIdentifier: map['uniqueIdentifier'] ?? '',
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageIdentity.fromJson(String source) =>
      PackageIdentity.fromMap(json.decode(source));

  @override
  String toString() =>
      'PackageIdentity(epubVersion: $epubVersion, uniqueIdentifier: $uniqueIdentifier, id: $id)';

  @override
  List<Object> get props => [epubVersion, uniqueIdentifier, id ?? ''];
}
