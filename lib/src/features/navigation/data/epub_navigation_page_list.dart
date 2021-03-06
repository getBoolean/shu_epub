part of shu_epub.features.navigation.data;

/// Page List -  Container for pagination information.
@Immutable()
class EpubNavigationPageList extends EquatableXml {
  static const elementName = 'pageList';

  final String? id;
  final String? classType;
  final List<EpubNavigationInfo> navigationInfoList;
  final List<EpubNavigationLabel> navigationLabels;

  /// Should have at least one item
  final List<EpubNavigationPageTarget> pageTargets;

  /// Create an [EpubNavigationPageList] object from the pageList XmlElement.
  ///
  /// Throws [EpubException] if the pageList element is not the root node
  factory EpubNavigationPageList.fromXmlElement(XmlElement pageListElement) {
    return EpubNavigationPageListReader.fromXmlElement(pageListElement);
  }

  factory EpubNavigationPageList.fromXmlString(String pageListString) {
    return EpubNavigationPageListReader.fromXmlString(pageListString);
  }

  /// Create an instance of [EpubNavigationPageList] from the [Uint8List] data
  /// of the pageList element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the pageList element
  factory EpubNavigationPageList.fromData(Uint8List pageListData) {
    return EpubNavigationPageListReader.fromData(pageListData);
  }

  const EpubNavigationPageList({
    this.id,
    this.classType,
    this.navigationInfoList = const [],
    this.navigationLabels = const [],
    this.pageTargets = const [],
  });

  EpubNavigationPageList copyWith({
    String? id,
    String? classType,
    List<EpubNavigationInfo>? navigationInfoList,
    List<EpubNavigationLabel>? navigationLabels,
    List<EpubNavigationPageTarget>? pageTargets,
  }) {
    return EpubNavigationPageList(
      id: id ?? this.id,
      classType: classType ?? this.classType,
      navigationInfoList: navigationInfoList ?? this.navigationInfoList,
      navigationLabels: navigationLabels ?? this.navigationLabels,
      pageTargets: pageTargets ?? this.pageTargets,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'classType': classType,
      'navigationInfoList': navigationInfoList.map((x) => x.toMap()).toList(),
      'navigationLabels': navigationLabels.map((x) => x.toMap()).toList(),
      'pageTargets': pageTargets.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigationPageList.fromMap(Map<String, dynamic> map) {
    return EpubNavigationPageList(
      id: map['id'],
      classType: map['classType'],
      navigationInfoList:
          List<EpubNavigationInfo>.from(map['navigationInfoList']
                  // ignore: unnecessary_lambdas
                  ?.map((e) => EpubNavigationInfo.fromMap(e)) ??
              const []),
      navigationLabels: List<EpubNavigationLabel>.from(
          // ignore: unnecessary_lambdas
          map['navigationLabels']?.map((e) => EpubNavigationLabel.fromMap(e)) ??
              const []),
      pageTargets: List<EpubNavigationPageTarget>.from(
          // ignore: unnecessary_lambdas
          map['pageTargets']?.map((e) => EpubNavigationPageTarget.fromMap(e)) ??
              const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationPageList.fromJson(String source) =>
      EpubNavigationPageList.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubNavigationPageList(id: $id, classType: $classType, navigationInfoList: $navigationInfoList, navigationLabels: $navigationLabels, pageTargets: $pageTargets)';
  }

  @override
  List<Object> get props {
    return [
      id ?? 'no id',
      classType ?? 'no classType',
      navigationInfoList,
      navigationLabels,
      pageTargets,
    ];
  }

  @override
  String toXmlString() => '<$elementName'
      '${id != null ? ' id="$id"' : ''}'
      '${classType != null ? ' class="$classType"' : ''}'
      '>'
      '${navigationInfoList.map((infoList) => infoList.toXmlString()).join('')}'
      '${navigationLabels.map((label) => label.toXmlString()).join('')}'
      '${pageTargets.map((pageTarget) => pageTarget.toXmlString()).join('')}'
      '</$elementName>';
}
