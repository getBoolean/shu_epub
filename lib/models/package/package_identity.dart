import 'dart:convert';

import 'package:equatable/equatable.dart';

class PackageIdentity extends Equatable {
  PackageIdentity({
    required this.version,
    required this.uniqueIdentifier,
    this.id,
  });

  final String version;

  final String uniqueIdentifier;

  final String? id;

  factory PackageIdentity.zero() {
    return PackageIdentity(
      version: 'unknown',
      uniqueIdentifier: 'unknown',
    );
  }

  PackageIdentity copyWith({
    String? version,
    String? uniqueIdentifier,
    String? id,
  }) {
    return PackageIdentity(
      version: version ?? this.version,
      uniqueIdentifier: uniqueIdentifier ?? this.uniqueIdentifier,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'version': version,
      'uniqueIdentifier': uniqueIdentifier,
      'id': id,
    };
  }

  factory PackageIdentity.fromMap(Map<String, dynamic> map) {
    return PackageIdentity(
      version: map['version'] ?? '',
      uniqueIdentifier: map['uniqueIdentifier'] ?? '',
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageIdentity.fromJson(String source) =>
      PackageIdentity.fromMap(json.decode(source));

  @override
  String toString() =>
      'PackageIdentity(version: $version, uniqueIdentifier: $uniqueIdentifier, id: $id)';

  @override
  List<Object> get props => [version, uniqueIdentifier, id ?? 'No id included'];
}
