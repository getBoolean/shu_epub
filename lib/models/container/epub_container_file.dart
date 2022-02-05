import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:equatable/equatable.dart';

import '../../epub_master.dart';

/// The container.xml file contains XML that uses the `urn:oasis:names:tc:opendocument:xmlns:container`
/// namespace for all of its elements and attributes. The `version="1.0"` attribute MUST be included
/// for all containers that conform to this version of the specification.
///
/// The rootfiles element MUST contain at least one <rootfile> element that has a media-type of `application/oebps-package+xml`.
class EpubContainerFile extends Equatable {
  static const filepath = 'META-INF/container.xml';

  EpubContainerFile.fromArchive(Archive archive)
      : rootfiles = ContainerReader.readRootfiles(archive);

  final List<RootFile> rootfiles;

  EpubContainerFile({
    required this.rootfiles,
  });

  EpubContainerFile copyWith({
    List<RootFile>? rootfiles,
  }) {
    return EpubContainerFile(
      rootfiles: rootfiles ?? this.rootfiles,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rootfiles': rootfiles.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubContainerFile.fromMap(Map<String, dynamic> map) {
    return EpubContainerFile(
      rootfiles: List<RootFile>.from(
          map['rootfiles']?.map((x) => RootFile.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubContainerFile.fromJson(String source) =>
      EpubContainerFile.fromMap(json.decode(source));

  @override
  String toString() => 'EpubContainerFile(rootfiles: $rootfiles)';

  @override
  List<Object> get props => [rootfiles];
}
