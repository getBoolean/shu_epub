part of shu_epub.features.epub.data;

@Immutable()
class EpubDetails extends Equatable {
  final EpubPackage? package;
  final EpubContainer? container;
  final EpubNavigation? navigation;

  /// Create an [EpubDetails] object from the epub container, package, and navgiation XmlElement.
  factory EpubDetails.fromXmlElement({
    required XmlElement containerElement,
    required XmlElement packageElement,
    required XmlElement navigationElement,
  }) {
    return EpubDetailsReader.fromXmlElement(
      containerElement: containerElement,
      packageElement: packageElement,
      navigationElement: navigationElement,
    );
  }

  /// Create an instance of [EpubDetails] from the [String] representation
  /// of the epub container, package, and navgiation elements
  ///
  /// Throws [EpubException] if the string does not have the corresponding element
  factory EpubDetails.fromXmlString({
    required String containerContent,
    required String packageContent,
    required String navigationContent,
  }) {
    return EpubDetailsReader.fromXmlString(
      containerContent: containerContent,
      packageContent: packageContent,
      navigationContent: navigationContent,
    );
  }

  /// Create an instance of [EpubDetails] from the [Uint8List] data
  /// of the epub container, package, and navgiation elements
  ///
  /// Throws [EpubException] if the data does not have the corresponding element
  factory EpubDetails.fromData({
    required Uint8List containerData,
    required Uint8List packageData,
    required Uint8List navigationData,
  }) {
    return EpubDetailsReader.fromData(
      containerData: containerData,
      packageData: packageData,
      navigationData: navigationData,
    );
  }

  // GENERATED DO NOT MODOFY

  const EpubDetails({
    this.package,
    this.container,
    this.navigation,
  });

  EpubDetails copyWith({
    EpubPackage? package,
    EpubContainer? container,
    EpubNavigation? navigation,
  }) {
    return EpubDetails(
      package: package ?? this.package,
      container: container ?? this.container,
      navigation: navigation ?? this.navigation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'package': package?.toMap(),
      'container': container?.toMap(),
      'navigation': navigation?.toMap(),
    };
  }

  factory EpubDetails.fromMap(Map<String, dynamic> map) {
    return EpubDetails(
      package:
          map['package'] != null ? EpubPackage.fromMap(map['package']) : null,
      container: map['package'] != null
          ? EpubContainer.fromMap(map['container'])
          : null,
      navigation: map['package'] != null
          ? EpubNavigation.fromMap(map['navigation'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubDetails.fromJson(String source) =>
      EpubDetails.fromMap(json.decode(source));

  @override
  String toString() =>
      'Epub(package: $package, container: $container, navigation: $navigation)';

  @override
  List<Object> get props => [
        package ?? 'no package',
        container ?? 'no container',
        navigation ?? 'no navigation'
      ];
}
