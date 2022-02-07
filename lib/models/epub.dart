import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import '../epub_master.dart';
import '../readers/epub_reader.dart';

class Epub extends Equatable {
  final PackageFile packageFile;
  final ContainerFile containerFile;

  /// Load an EPUB file into memory and return the parsed [Epub] object
  ///
  /// ```
  /// final file = File("Guardian.epub");
  /// final epub = Epub.loadFromData(file.readAsBytesSync());
  /// ```
  factory Epub.loadFromData(Uint8List bytes) {
    return EpubReader.read(bytes);
  }

  // GENERATED DO NOT MODOFY

  Epub({
    required this.packageFile,
    required this.containerFile,
  });

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
  String toString() =>
      'Epub(packageFile: $packageFile, containerFile: $containerFile)';

  @override
  List<Object> get props => [packageFile, containerFile];
}
