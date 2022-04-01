part of shu_epub.features.navigation.data;

/// Navigation List - container for distinct, flat sets of navigable elements,
/// e.g. notes, figures, tables, etc.  Essentially a flat version of navMap.
/// The "class" attribute describes the type of object contained in this
/// navList, using dtbook element names, e.g., note.
@Immutable()
class EpubNavigationList extends EquatableXml {
  static const elementName = 'navList';

  final List<EpubNavigationInfo> navigationInfoList;

  /// Should have at least one item
  final List<EpubNavigationLabel> navigationLabels;

  /// Should have at least one item
  final List<EpubNavigationTarget> navigationTargets;

  /// Create an [EpubNavigationList] object from the navList XmlElement.
  ///
  /// Throws [EpubException] if the navList element is not the root node
  factory EpubNavigationList.fromXmlElement(XmlElement navListElement) {
    return EpubNavigationListReader.fromXmlElement(navListElement);
  }

  /// Create an instance of [EpubNavigationList] from the [String] representation
  /// of the navList element
  ///
  /// Throws [EpubException] if the string does not have the navList element
  factory EpubNavigationList.fromXmlString(String navListString) {
    return EpubNavigationListReader.fromXmlString(navListString);
  }

  /// Create an instance of [EpubNavigationList] from the [Uint8List] data
  /// of the navList element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navList element
  factory EpubNavigationList.fromData(Uint8List navListData) {
    return EpubNavigationListReader.fromData(navListData);
  }

  const EpubNavigationList({
    this.navigationInfoList = const [],
    this.navigationLabels = const [],
    this.navigationTargets = const [],
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
      navigationInfoList:
          List<EpubNavigationInfo>.from(map['navigationInfoList']?.map(
                // ignore: unnecessary_lambdas
                (e) => EpubNavigationInfo.fromMap(e),
              ) ??
              const []),
      navigationLabels: List<EpubNavigationLabel>.from(
          // ignore: unnecessary_lambdas
          map['navigationLabels']?.map((e) => EpubNavigationLabel.fromMap(e)) ??
              const []),
      navigationTargets: List<EpubNavigationTarget>.from(
          map['navigationTargets']?.map(
                // ignore: unnecessary_lambdas
                (e) => EpubNavigationTarget.fromMap(e),
              ) ??
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

  @override
  String toXmlString() => '<$elementName>'
      '${navigationInfoList.map((infoList) => infoList.toXmlString()).join('')}'
      '${navigationLabels.map((label) => label.toXmlString()).join('')}'
      '${navigationTargets.map((target) => target.toXmlString()).join('')}'
      '</$elementName>';
}
