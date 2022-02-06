import 'dart:convert';

import 'package:equatable/equatable.dart';

class PackageIdentity extends Equatable {
  PackageIdentity({
    required this.version,
    required this.uniqueIdentifier,
  });

  final String version;

  final String uniqueIdentifier;

  factory PackageIdentity.zero() {
    return PackageIdentity(
      version: 'unknown',
      uniqueIdentifier: 'unknown',
    );
  }

  PackageIdentity copyWith({
    String? version,
    String? uniqueIdentifier,
  }) {
    return PackageIdentity(
      version: version ?? this.version,
      uniqueIdentifier: uniqueIdentifier ?? this.uniqueIdentifier,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'version': version,
      'uniqueIdentifier': uniqueIdentifier,
    };
  }

  factory PackageIdentity.fromMap(Map<String, dynamic> map) {
    return PackageIdentity(
      version: map['version'] ?? '',
      uniqueIdentifier: map['uniqueIdentifier'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageIdentity.fromJson(String source) =>
      PackageIdentity.fromMap(json.decode(source));

  @override
  String toString() =>
      'PackageIdentity(version: $version, uniqueIdentifier: $uniqueIdentifier)';

  @override
  List<Object> get props => [version, uniqueIdentifier];
}
