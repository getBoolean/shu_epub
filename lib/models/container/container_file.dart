import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../epub_master.dart';

/// The container.xml file contains XML that uses the `urn:oasis:names:tc:opendocument:xmlns:container`
/// namespace for all of its elements and attributes. The `version="1.0"` attribute MUST be included
/// for all containers that conform to this version of the specification.
///
/// The rootfiles element MUST contain at least one <rootfile> element that has a media-type of `application/oebps-package+xml`.
class ContainerFile extends Equatable {
  static const filepath = 'META-INF/container.xml';
  final List<RootFile> rootfileList;
  final String version;

  ContainerFile({
    required this.rootfileList,
    required this.version,
  });

  /// If there are multiple [RootFile]s with mime type [EpubConstants.kOPFMimeType], the first one will be considered the rootfile
  RootFile get rootfile => rootfileList.firstWhere((element) => element.mediaType == EpubConstants.kOPFMimeType);

  ContainerFile copyWith({
    List<RootFile>? rootfileList,
    String? version,
  }) {
    return ContainerFile(
      rootfileList: rootfileList ?? this.rootfileList,
      version: version ?? this.version,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rootfiles': rootfileList.map((x) => x.toMap()).toList(),
      'version': version,
    };
  }

  factory ContainerFile.fromMap(Map<String, dynamic> map) {
    return ContainerFile(
      rootfileList: List<RootFile>.from(
          map['rootfiles']?.map((x) => RootFile.fromMap(x))),
      version: map['version'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContainerFile.fromJson(String source) =>
      ContainerFile.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubContainerFile(rootfiles: $rootfileList, version: $version)';

  @override
  List<Object> get props => [rootfileList, version];
}
