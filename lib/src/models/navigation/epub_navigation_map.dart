part of shu_epub.models;

/// Navigation Structure - container for all of the NCX objects that are part
/// of the hierarchical structure of the document.
class EpubNavigationMap extends Equatable {
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

  factory EpubNavigationMap.fromString(String navMap) {
    return EpubNavigationMapReader.fromString(navMap);
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
          map['navigationInfoList']?.map(EpubNavigationInfo.fromMap)),
      navigationLabels: List<EpubNavigationLabel>.from(
          map['navigationLabels']?.map(EpubNavigationLabel.fromMap)),
      navigationPoints: List<EpubNavigationPoint>.from(
          map['navigationPoints']?.map(EpubNavigationPoint.fromMap)),
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
}
