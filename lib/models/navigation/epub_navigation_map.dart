part of shu_epub.models;

/// navInfo*, navLabel*, navPoint+
class EpubNavigationMap extends Equatable {
  final List<EpubNavigationInfo> navigationInfo;

  final List<EpubNavigationLabel> navigationLabel;

  final List<EpubNavigationPoint> navigationPoint;

  const EpubNavigationMap({
    required this.navigationInfo,
    required this.navigationLabel,
    required this.navigationPoint,
  });

  factory EpubNavigationMap.zero() {
    return EpubNavigationMap(
      navigationInfo: [],
      navigationLabel: [],
      navigationPoint: [],
    );
  }

  EpubNavigationMap copyWith({
    List<EpubNavigationInfo>? navigationInfo,
    List<EpubNavigationLabel>? navigationLabel,
    List<EpubNavigationPoint>? navigationPoint,
  }) {
    return EpubNavigationMap(
      navigationInfo: navigationInfo ?? this.navigationInfo,
      navigationLabel: navigationLabel ?? this.navigationLabel,
      navigationPoint: navigationPoint ?? this.navigationPoint,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'navigationInfo': navigationInfo.map((x) => x.toMap()).toList(),
      'navigationLabel': navigationLabel.map((x) => x.toMap()).toList(),
      'navigationPoint': navigationPoint.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigationMap.fromMap(Map<String, dynamic> map) {
    return EpubNavigationMap(
      navigationInfo: List<EpubNavigationInfo>.from(
          map['navigationInfo']?.map((x) => EpubNavigationInfo.fromMap(x)) ??
              const []),
      navigationLabel: List<EpubNavigationLabel>.from(
          map['navigationLabel']?.map((x) => EpubNavigationLabel.fromMap(x)) ??
              const []),
      navigationPoint: List<EpubNavigationPoint>.from(
          map['navigationPoint']?.map((x) => EpubNavigationPoint.fromMap(x)) ??
              const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationMap.fromJson(String source) =>
      EpubNavigationMap.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubNavigationMap(navigationInfo: $navigationInfo, navigationLabel: $navigationLabel, navigationPoint: $navigationPoint)';

  @override
  List<Object> get props => [navigationInfo, navigationLabel, navigationPoint];
}
