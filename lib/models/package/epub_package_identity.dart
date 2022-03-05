part of shu_epub.models;

class EpubPackageIdentity extends Equatable {
  final String epubVersion;

  final String uniqueIdentifier;

  final String? id;

  factory EpubPackageIdentity.zero() {
    return EpubPackageIdentity(
      epubVersion: 'unknown',
      uniqueIdentifier: 'unknown',
    );
  }

  // GENERATED DO NOT MODOFY

  const EpubPackageIdentity({
    required this.epubVersion,
    required this.uniqueIdentifier,
    this.id,
  });

  EpubPackageIdentity copyWith({
    String? epubVersion,
    String? uniqueIdentifier,
    String? id,
  }) {
    return EpubPackageIdentity(
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

  factory EpubPackageIdentity.fromMap(Map<String, dynamic> map) {
    return EpubPackageIdentity(
      epubVersion: map['epubVersion'] ?? '',
      uniqueIdentifier: map['uniqueIdentifier'] ?? '',
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubPackageIdentity.fromJson(String source) =>
      EpubPackageIdentity.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubPackageIdentity(epubVersion: $epubVersion, uniqueIdentifier: $uniqueIdentifier, id: $id)';

  @override
  List<Object> get props => [epubVersion, uniqueIdentifier, id ?? ''];
}
