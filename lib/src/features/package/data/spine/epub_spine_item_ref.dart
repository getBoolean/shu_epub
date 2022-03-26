part of shu_epub.features.package.data;

class EpubSpineItemRef extends Equatable {
  static const elementName = 'itemref';
  
  final String? idref;

  /// If false, it may be viewed separately from the main flow
  /// of the order defined by the [EpubManifest]
  ///
  /// Designates whether the associated OPS Content Document is
  /// primary (`linear`=`true`, which is the default when linear
  /// is not present) or auxiliary (`linear`=`false`.)
  final bool linear;

  bool get isPrimary => linear;
  bool get isAuxiliary => !linear;

  /// Create an [EpubSpineItemRef] object from the itemref XmlElement.
  ///
  /// Throws [EpubException] if the itemref element is not the root node
  factory EpubSpineItemRef.fromXmlElement(XmlElement itemrefElement) {
    return EpubSpineItemRefReader.fromXmlElement(itemrefElement);
  }
  
  /// Create an instance of [EpubSpineItemRef] from the [String] representation
  /// of the itemref element
  ///
  /// Throws [EpubException] if the string does not have the itemref element
  factory EpubSpineItemRef.fromString(String itemrefString) {
    return EpubSpineItemRefReader.fromString(itemrefString);
  }
  
  /// Create an instance of [EpubSpineItemRef] from the [Uint8List] data
  /// of the itemref element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the itemref element
  factory EpubSpineItemRef.fromData(Uint8List itemrefData) {
    return EpubSpineItemRefReader.fromData(itemrefData);
  }

  const EpubSpineItemRef({
    this.idref,
    this.linear = true,
  });

  EpubSpineItemRef copyWith({
    String? idref,
    bool? linear,
  }) {
    return EpubSpineItemRef(
      idref: idref ?? this.idref,
      linear: linear ?? this.linear,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idref': idref,
      'linear': linear,
    };
  }

  factory EpubSpineItemRef.fromMap(Map<String, dynamic> map) {
    return EpubSpineItemRef(
      idref: map['idref'],
      linear: map['linear'] ?? true,
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubSpineItemRef.fromJson(String source) =>
      EpubSpineItemRef.fromMap(json.decode(source));

  @override
  String toString() => 'EpubSpineItemRef(idref: $idref, linear: $linear)';

  @override
  List<Object> get props => [idref ?? 'no idref', linear];
}
