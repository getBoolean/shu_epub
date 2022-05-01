part of shu_epub.features.navigation.data;

/// Contains description(s) of target, as well as a pointer to entire content
/// of target. Hierarchy is represented by nesting navPoints.
/// [EpubNavigationPoint.classType] attribute
@Immutable()
class EpubNavigationPoint extends EquatableXml {
  static const elementName = 'navPoint';
  final String? id;

  /// Describes the kind of structural unit this object represents (e.g.,
  /// "chapter", "section").
  final String? classType;

  /// Should contain valid values that reflect the linear document reading
  /// order. This could, for example, be used when one is navigating a
  /// [EpubNavigation.pageList] to find a corresponding location in the
  /// [EpubNavigation.navigationMap].
  final String? playOrder;

  /// Should have at least one item
  final List<EpubNavigationLabel> labels;

  /// Pointer to XML element.
  final EpubNavigationContent? content;

  /// Hierarchy is represented by nesting navPoints.
  final List<EpubNavigationPoint> childNavigationPoints;

  /// Create an [EpubNavigationPoint] object from the navPoint XmlElement.
  ///
  /// Throws [EpubException] if the navPoint element is not the root node
  factory EpubNavigationPoint.fromXmlElement(XmlElement navPointElement) {
    return EpubNavigationPointReader.fromXmlElement(navPointElement);
  }

  factory EpubNavigationPoint.fromXmlString(String navPointString) {
    return EpubNavigationPointReader.fromXmlString(navPointString);
  }

  /// Create an instance of [EpubNavigationPoint] from the [Uint8List] data
  /// of the navPoint element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navPoint element
  factory EpubNavigationPoint.fromData(Uint8List navPointData) {
    return EpubNavigationPointReader.fromData(navPointData);
  }

  const EpubNavigationPoint({
    this.id,
    this.classType,
    this.playOrder,
    this.childNavigationPoints = const [],
    this.content,
    this.labels = const [],
  });

  EpubNavigationPoint copyWith({
    String? id,
    String? classType,
    String? playOrder,
    List<EpubNavigationPoint>? childNavigationPoints,
    EpubNavigationContent? content,
    List<EpubNavigationLabel>? labels,
  }) {
    return EpubNavigationPoint(
      id: id ?? this.id,
      classType: classType ?? this.classType,
      playOrder: playOrder ?? this.playOrder,
      childNavigationPoints:
          childNavigationPoints ?? this.childNavigationPoints,
      content: content ?? this.content,
      labels: labels ?? this.labels,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'classType': classType,
      'playOrder': playOrder,
      'childNavigationPoints':
          childNavigationPoints.map((x) => x.toMap()).toList(),
      'content': content?.toMap(),
      'labels': labels.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigationPoint.fromMap(Map<String, dynamic> map) {
    return EpubNavigationPoint(
      id: map['id'],
      classType: map['classType'],
      playOrder: map['playOrder'],
      childNavigationPoints: List<EpubNavigationPoint>.from(
        map['childNavigationPoints']?.map(
          // ignore: unnecessary_lambdas
          (e) => EpubNavigationPoint.fromMap(e),
        ),
      ),
      content: map['content'] != null
          ? EpubNavigationContent.fromMap(map['content'])
          : null,
      labels: List<EpubNavigationLabel>.from(
        // ignore: unnecessary_lambdas
        map['labels']?.map((e) => EpubNavigationLabel.fromMap(e)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationPoint.fromJson(String source) =>
      EpubNavigationPoint.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubNavigationPoint(id: $id, classType: $classType, playOrder: $playOrder, childNavigationPoints: $childNavigationPoints, content: $content, labels: $labels)';
  }

  @override
  List<Object> get props {
    return [
      id ?? 'no id',
      classType ?? 'no classType',
      playOrder ?? 'no playOrder',
      childNavigationPoints,
      content ?? 'no content',
      labels,
    ];
  }

  @override
  String toXmlString() => '<$elementName'
      '${id != null ? ' id="$id"' : ''}'
      '${classType != null ? ' class="$classType"' : ''}'
      '${playOrder != null ? ' playOrder="$playOrder"' : ''}'
      '>'
      '${content != null ? content!.toXmlString() : ''}'
      '${labels.map((label) => label.toXmlString()).join('')}'
      '${childNavigationPoints.map((navPoint) => navPoint.toXmlString()).join('')}'
      '</$elementName>';
}
