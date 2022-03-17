part of shu_epub.models;

class EpubNavigationList extends Equatable {
  final List<EpubNavigationInfo> navigationInfoList;

  /// Should have at least one item
  final List<EpubNavigationLabel> navigationLabels;

  /// Should have at least one item
  final List<EpubNavigationTarget> navigationTargets;

  factory EpubNavigationList.zero() {
    return EpubNavigationList(
      navigationInfoList: [],
      navigationLabels: [],
      navigationTargets: [],
    );
  }

  const EpubNavigationList({
    required this.navigationInfoList,
    required this.navigationLabels,
    required this.navigationTargets,
  });

  EpubNavigationList copyWith({
    List<EpubNavigationInfo>? navigationInfoList,
    List<EpubNavigationLabel>? navigationLabels,
    List<EpubNavigationTarget>? navigationTargets,
  }) {
    return EpubNavigationList(
      navigationInfoList: navigationInfoList ?? this.navigationInfoList,
      navigationLabels: navigationLabels ?? this.navigationLabels,
      navigationTargets: navigationTargets ?? this.navigationTargets,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'navigationInfoList': navigationInfoList.map((x) => x.toMap()).toList(),
      'navigationLabels': navigationLabels.map((x) => x.toMap()).toList(),
      'navigationTargets': navigationTargets.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigationList.fromMap(Map<String, dynamic> map) {
    return EpubNavigationList(
      navigationInfoList: List<EpubNavigationInfo>.from(
          map['navigationInfoList']
                  ?.map((x) => EpubNavigationInfo.fromMap(x)) ??
              const []),
      navigationLabels: List<EpubNavigationLabel>.from(
          map['navigationLabels']?.map((x) => EpubNavigationLabel.fromMap(x)) ??
              const []),
      navigationTargets: List<EpubNavigationTarget>.from(
          map['navigationTargets']
                  ?.map((x) => EpubNavigationTarget.fromMap(x)) ??
              const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationList.fromJson(String source) =>
      EpubNavigationList.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubNavigationList(navigationInfoList: $navigationInfoList, navigationLabels: $navigationLabels, navigationTargets: $navigationTargets)';

  @override
  List<Object> get props =>
      [navigationInfoList, navigationLabels, navigationTargets];
}
