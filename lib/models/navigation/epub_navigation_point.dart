part of shu_epub.models;

/// Contains description(s) of target, as well as a pointer to entire content
/// of target. Hierarchy is represented by nesting navPoints.
/// [EpubNavigationPoint.classType] attribute
class EpubNavigationPoint extends Equatable {
  final String id;

  /// Describes the kind of structural unit this object represents (e.g.,
  /// "chapter", "section").
  final String? classType;

  /// Should contain valid values that reflect the linear document reading
  /// order. This could, for example, be used when one is navigating a
  /// [EpubNavigation.pageList] to find a corresponding location in the 
  /// [EpubNavigation.navigationMap].
  final String? playOrder;

  /// Hierarchy is represented by nesting navPoints.
  final List<EpubNavigationPoint> childNavigationPoints;

  /// Pointer to XML element.
  final EpubNavigationContent content;

  /// Should have at least one item
  final List<EpubNavigationLabel> labels;

  const EpubNavigationPoint({
    required this.id,
    this.classType,
    this.playOrder,
    required this.childNavigationPoints,
    required this.content,
    required this.labels,
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
      'content': content.toMap(),
      'labels': labels.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigationPoint.fromMap(Map<String, dynamic> map) {
    return EpubNavigationPoint(
      id: map['id'] ?? '',
      classType: map['classType'],
      playOrder: map['playOrder'],
      childNavigationPoints: List<EpubNavigationPoint>.from(
          map['childNavigationPoints']
                  ?.map((x) => EpubNavigationPoint.fromMap(x)) ??
              const []),
      content: EpubNavigationContent.fromMap(map['content']),
      labels: List<EpubNavigationLabel>.from(
          map['labels']?.map((x) => EpubNavigationLabel.fromMap(x)) ??
              const []),
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
      id,
      classType ?? 'no classType',
      playOrder ?? 'no playOrder',
      childNavigationPoints,
      content,
      labels,
    ];
  }
}
