part of shu_epub.features.navigation.data;

/// Navigation Structure - container for all of the NCX objects that are part
/// of the hierarchical structure of the document.
class EpubNavigationMap extends EquatableXml {
  static const elementName = 'navMap';

  final String? id;

  final List<EpubNavigationInfo> navigationInfoList;

  final List<EpubNavigationLabel> navigationLabels;

  /// List of Navigation Point - which contains description(s) of target, as
  /// well as a pointer to entire content of target. Hierarchy is represented by
  /// nesting navPoints.  "class" attribute describes the kind of structural
  /// unit this object represents (e.g., "chapter", "section").
  ///
  /// **Should have at least 1 item**
  final List<EpubNavigationPoint> navigationPoints;

  /// Create an [EpubNavigationMap] object from the navMap XmlElement.
  ///
  /// Throws [EpubException] if the navMap element is not the root node
  factory EpubNavigationMap.fromXmlElement(XmlElement element) {
    return EpubNavigationMapReader.fromXmlElement(element);
  }

  factory EpubNavigationMap.fromXmlString(String navMap) {
    return EpubNavigationMapReader.fromXmlString(navMap);
  }

  /// Create an instance of [EpubNavigationMap] from the [Uint8List] data
  /// of the navMap element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navMap element
  factory EpubNavigationMap.fromData(Uint8List data) {
    return EpubNavigationMapReader.fromData(data);
  }

  const EpubNavigationMap({
    this.id,
    this.navigationInfoList = const [],
    this.navigationLabels = const [],
    this.navigationPoints = const [],
  });

  factory EpubNavigationMap.zero() {
    return EpubNavigationMap(
      navigationInfoList: [],
      navigationLabels: [],
      navigationPoints: [],
    );
  }

  EpubNavigationMap copyWith({
    String? id,
    List<EpubNavigationInfo>? navigationInfoList,
    List<EpubNavigationLabel>? navigationLabels,
    List<EpubNavigationPoint>? navigationPoints,
  }) {
    return EpubNavigationMap(
      id: id ?? this.id,
      navigationInfoList: navigationInfoList ?? this.navigationInfoList,
      navigationLabels: navigationLabels ?? this.navigationLabels,
      navigationPoints: navigationPoints ?? this.navigationPoints,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'navigationInfoList': navigationInfoList.map((x) => x.toMap()).toList(),
      'navigationLabels': navigationLabels.map((x) => x.toMap()).toList(),
      'navigationPoints': navigationPoints.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigationMap.fromMap(Map<String, dynamic> map) {
    return EpubNavigationMap(
      id: map['id'],
      navigationInfoList: List<EpubNavigationInfo>.from(
          // ignore: unnecessary_lambdas
          map['navigationInfoList']?.map((e) => EpubNavigationInfo.fromMap(e))),
      navigationLabels: List<EpubNavigationLabel>.from(
          // ignore: unnecessary_lambdas
          map['navigationLabels']?.map((e) => EpubNavigationLabel.fromMap(e))),
      navigationPoints: List<EpubNavigationPoint>.from(
          // ignore: unnecessary_lambdas
          map['navigationPoints']?.map((e) => EpubNavigationPoint.fromMap(e))),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationMap.fromJson(String source) =>
      EpubNavigationMap.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubNavigationMap(id: $id, navigationInfoList: $navigationInfoList, navigationLabels: $navigationLabels, navigationPoints: $navigationPoints)';
  }

  @override
  List<Object> get props =>
      [id ?? 'no id', navigationInfoList, navigationLabels, navigationPoints];

  @override
  String toXmlString() => '<$elementName'
      '${id != null ? ' id="$id"' : ''}'
      '>'
      '${navigationInfoList.map((infoList) => infoList.toXmlString()).join('')}'
      '${navigationLabels.map((label) => label.toXmlString()).join('')}'
      '${navigationPoints.map((navPoint) => navPoint.toXmlString()).join('')}'
      '</$elementName>';
}
