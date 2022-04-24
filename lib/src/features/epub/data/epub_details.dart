part of shu_epub.features.epub.data;

@Immutable()
class EpubDetails extends Equatable {
  final EpubPackage? package;
  final EpubContainer? container;
  final EpubNavigation? navigation;

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
      container: map['container'] != null
          ? EpubContainer.fromMap(map['container'])
          : null,
      navigation: map['navigation'] != null
          ? EpubNavigation.fromMap(map['navigation'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubDetails.fromJson(String source) =>
      EpubDetails.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubDetails(package: $package, container: $container, navigation: $navigation)';

  @override
  List<Object> get props => [
        package ?? 'no package',
        container ?? 'no container',
        navigation ?? 'no navigation'
      ];
}
