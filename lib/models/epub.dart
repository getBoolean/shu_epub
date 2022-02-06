import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import '../epub_master.dart';
import '../readers/epub_reader.dart';

class Epub extends Equatable {
  Epub({
    required this.packageMetadata,
    required this.containerFile,
  });

  final PackageMetadata packageMetadata;
  final ContainerFile containerFile;

  factory Epub.readBook(Uint8List bytes) {
    return EpubReader.readBook(bytes);
  }

  Epub copyWith({
    PackageMetadata? packageMetadata,
    ContainerFile? containerFile,
  }) {
    return Epub(
      packageMetadata: packageMetadata ?? this.packageMetadata,
      containerFile: containerFile ?? this.containerFile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'packageMetadata': packageMetadata.toMap(),
      'containerFile': containerFile.toMap(),
    };
  }

  factory Epub.fromMap(Map<String, dynamic> map) {
    return Epub(
      packageMetadata: PackageMetadata.fromMap(map['packageMetadata']),
      containerFile: ContainerFile.fromMap(map['containerFile']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Epub.fromJson(String source) => Epub.fromMap(json.decode(source));

  @override
  String toString() =>
      'Epub(packageMetadata: $packageMetadata, containerFile: $containerFile)';

  @override
  List<Object> get props => [packageMetadata, containerFile];
}
