part of shu_epub.models;

class Epub extends Equatable {
  final EpubPackageFile packageFile;
  final EpubContainerFile containerFile;

  /// Load an EPUB file into memory and return the parsed [Epub] object
  ///
  /// ```
  /// final file = File("Guardian.epub");
  /// final epub = Epub.loadFromData(file.readAsBytesSync());
  /// ```
  factory Epub.fromData(Uint8List bytes) {
    return EpubReader.fromData(bytes);
  }

  // /// Load a cached EPUB into memory and return the parsed [Epub] object. This is preferred over `Epub.loadFromData`
  // /// because it only loads the parts of the Epub file it needs into memory.
  // ///
  // /// Not available on Web.
  // ///
  // /// ```
  // /// final file = File("Guardian.epub");
  // /// final epub = Epub.loadFromData(file.readAsBytesSync());
  // /// ```
  // factory Epub.loadFromCache(String id) {
  //   return EpubReader.loadFromCache(id);
  // }

  // /// Cache an epub on the device for faster loading times when using `Epub.loadFromCache`
  // ///
  // /// Not available on Web.
  // static String saveToCache(Uint8List bytes, String path, {String? id}) {

  // }

  // GENERATED DO NOT MODOFY

  Epub({
    required this.packageFile,
    required this.containerFile,
  });

  Epub copyWith({
    EpubPackageFile? packageFile,
    EpubContainerFile? containerFile,
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
      packageFile: EpubPackageFile.fromMap(map['packageFile']),
      containerFile: EpubContainerFile.fromMap(map['containerFile']),
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
