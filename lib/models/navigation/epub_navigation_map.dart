part of shu_epub.models;

/// Navigation Structure - container for all of the NCX objects that are part
/// of the hierarchical structure of the document.
class EpubNavigationMap extends Equatable {
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

  const EpubNavigationMap({
    this.id,
    required this.navigationInfoList,
    required this.navigationLabels,
    required this.navigationPoints,
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
      navigationInfoList: List<EpubNavigationInfo>.from(map['navigationInfoList']?.map((x) => EpubNavigationInfo.fromMap(x)) ?? const []),
      navigationLabels: List<EpubNavigationLabel>.from(map['navigationLabels']?.map((x) => EpubNavigationLabel.fromMap(x)) ?? const []),
      navigationPoints: List<EpubNavigationPoint>.from(map['navigationPoints']?.map((x) => EpubNavigationPoint.fromMap(x)) ?? const []),
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
  List<Object> get props => [id ?? 'no id', navigationInfoList, navigationLabels, navigationPoints];
}
