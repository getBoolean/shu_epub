part of shu_epub.features.epub.data;

@Immutable()
class Epub extends Equatable {
  final EpubPackage package;
  final EpubContainer container;
  final EpubNavigation navigation;

  /// Load an EPUB file into memory and return the parsed [Epub] object
  ///
  /// ```
  /// final file = File("Guardian.epub");
  /// final epub = Epub.fromData(file.readAsBytesSync());
  /// ```
  factory Epub.fromData({
    required Uint8List data,
    required String bookId,
  }) {
    return EpubReader.fromData(data: data, bookId: bookId);
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

  const Epub({
    required this.package,
    required this.container,
    required this.navigation,
  });

  Epub copyWith({
    EpubPackage? package,
    EpubContainer? container,
    EpubNavigation? navigation,
  }) {
    return Epub(
      package: package ?? this.package,
      container: container ?? this.container,
      navigation: navigation ?? this.navigation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'package': package.toMap(),
      'container': container.toMap(),
      'navigation': navigation.toMap(),
    };
  }

  factory Epub.fromMap(Map<String, dynamic> map) {
    return Epub(
      package: EpubPackage.fromMap(map['package']),
      container: EpubContainer.fromMap(map['container']),
      navigation: EpubNavigation.fromMap(map['navigation']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Epub.fromJson(String source) => Epub.fromMap(json.decode(source));

  @override
  String toString() =>
      'Epub(package: $package, container: $container, navigation: $navigation)';

  @override
  List<Object> get props => [package, container, navigation];
}
