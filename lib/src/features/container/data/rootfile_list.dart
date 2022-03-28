part of shu_epub.features.container.data;

class RootfileList extends Equatable {
  static const elementName = 'rootfiles';

  final List<Rootfile> items;

  /// Create an [RootfileList] object from the rootfiles XmlElement.
  ///
  /// Throws [EpubException] if the rootfiles element is not the root node
  factory RootfileList.fromXmlElement(XmlElement rootfilesElement) {
    return RootfileListReader.fromXmlElement(rootfilesElement);
  }

  /// Create an instance of [RootfileList] from the [String] representation
  /// of the rootfiles element
  ///
  /// Throws [EpubException] if the string does not have the rootfiles element
  factory RootfileList.fromXmlString(String rootfilesString) {
    return RootfileListReader.fromXmlString(rootfilesString);
  }

  /// Create an instance of [RootfileList] from the [Uint8List] data
  /// of the rootfiles element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the rootfiles element
  factory RootfileList.fromData(Uint8List rootfilesData) {
    return RootfileListReader.fromData(rootfilesData);
  }

  const RootfileList({
    this.items = const [],
  });

  RootfileList copyWith({
    List<Rootfile>? items,
  }) {
    return RootfileList(
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory RootfileList.fromMap(Map<String, dynamic> map) {
    return RootfileList(
      // ignore: unnecessary_lambdas
      items: List<Rootfile>.from(map['items']?.map((e) => Rootfile.fromMap(e))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RootfileList.fromJson(String source) =>
      RootfileList.fromMap(json.decode(source));

  @override
  String toString() => 'RootfileList(items: $items)';

  @override
  List<Object> get props => [items];
}
