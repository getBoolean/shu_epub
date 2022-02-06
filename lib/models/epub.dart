import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import '../epub_master.dart';
import '../readers/epub_reader.dart';

class Epub extends Equatable {
  Epub({
    required this.packageFile,
    required this.containerFile,
  });

  final PackageFile packageFile;
  final ContainerFile containerFile;

  factory Epub.read(Uint8List bytes) {
    return EpubReader.read(bytes);
  }

  Epub copyWith({
    PackageFile? packageFile,
    ContainerFile? containerFile,
  }) {
    return Epub(
      packageFile: packageFile ?? this.packageFile,
      containerFile: containerFile ?? this.containerFile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'packageFile': packageFile.toMap(),
      'containerFile': containerFile.toMap(),
    };
  }

  factory Epub.fromMap(Map<String, dynamic> map) {
    return Epub(
      packageFile: PackageFile.fromMap(map['packageFile']),
      containerFile: ContainerFile.fromMap(map['containerFile']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Epub.fromJson(String source) => Epub.fromMap(json.decode(source));

  @override
  String toString() => 'Epub(packageFile: $packageFile, containerFile: $containerFile)';

  @override
  List<Object> get props => [packageFile, containerFile];
}
