part of shu_epub.features.package.data;

class EpubManifest extends Equatable {
  static const elementName = 'manifest';

  final List<EpubManifestItem> items;

  /// Create an [EpubManifest] object from the manifest XmlElement.
  ///
  /// Throws [EpubException] if the manifest element is not the root node
  factory EpubManifest.fromXmlElement(XmlElement manifestElement) {
    return EpubManifestReader.fromXmlElement(manifestElement);
  }

  /// Create an instance of [EpubManifest] from the [String] representation
  /// of the manifest element
  ///
  /// Throws [EpubException] if the string does not have the manifest element
  factory EpubManifest.fromXmlString(String manifestString) {
    return EpubManifestReader.fromXmlString(manifestString);
  }

  /// Create an instance of [EpubManifest] from the [Uint8List] data
  /// of the manifest element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the manifest element
  factory EpubManifest.fromData(Uint8List manifestData) {
    return EpubManifestReader.fromData(manifestData);
  }

  const EpubManifest({
    this.items = const [],
  });

  EpubManifest copyWith({
    List<EpubManifestItem>? items,
  }) {
    return EpubManifest(
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((item) => item.toMap()),
    };
  }

  factory EpubManifest.fromMap(Map<String, dynamic> map) {
    return EpubManifest(
      items: List<EpubManifestItem>.from(
          // ignore: unnecessary_lambdas
          map['items']?.map((e) => EpubManifestItem.fromMap(e))),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubManifest.fromJson(String source) =>
      EpubManifest.fromMap(json.decode(source));

  @override
  String toString() => 'EpubManifest(items: $items)';

  @override
  List<Object> get props => [items];
}
