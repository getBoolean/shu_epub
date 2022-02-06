import 'dart:convert';

import 'package:equatable/equatable.dart';

class PackageIdentity extends Equatable {
  PackageIdentity({
    required this.version,
    required this.uniqueIdentifier,
    required this.packageContent,
    this.id,
  });

  final String version;

  final String uniqueIdentifier;

  final String packageContent;

  final String? id;

  factory PackageIdentity.zero() {
    return PackageIdentity(
      version: 'unknown',
      uniqueIdentifier: 'unknown',
      packageContent: ''
    );
  }

  PackageIdentity copyWith({
    String? version,
    String? uniqueIdentifier,
    String? packageContent,
    String? id,
  }) {
    return PackageIdentity(
      version: version ?? this.version,
      uniqueIdentifier: uniqueIdentifier ?? this.uniqueIdentifier,
      packageContent: packageContent ?? this.packageContent,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'version': version,
      'uniqueIdentifier': uniqueIdentifier,
      'packageContent': packageContent,
      'id': id,
    };
  }

  factory PackageIdentity.fromMap(Map<String, dynamic> map) {
    return PackageIdentity(
      version: map['version'] ?? '',
      uniqueIdentifier: map['uniqueIdentifier'] ?? '',
      packageContent: map['packageContent'] ?? '',
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageIdentity.fromJson(String source) =>
      PackageIdentity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubPackageIdentity(version: $version, uniqueIdentifier: $uniqueIdentifier, packageContent: $packageContent, id: $id)';
  }

  @override
  List<Object> get props =>
      [version, uniqueIdentifier, packageContent, id ?? ''];
}
