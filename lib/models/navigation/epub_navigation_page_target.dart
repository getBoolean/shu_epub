part of shu_epub.models;

/// Page Target -  Container for text, image, and content elements
/// containing navigational information for pages.  The "value" attribute is a
/// positive integer representing the numeric value associated with a page.
/// Combination of values of type and value attributes must be unique, when
/// value attribute is present.
class EpubNavigationPageTarget extends Equatable {
  final String? id;
  final String? value;
  // enum
  final EpubNavigationPageTargetType type;
  final String? classType;

  /// Should contain valid values that reflect the linear document reading
  /// order. This could, for example, be used when one is navigating a
  /// [EpubNavigation.pageList] to find a corresponding location in the
  /// [EpubNavigation.navigationMap].
  final String? playOrder;

  /// Should have at least one item
  final List<EpubNavigationLabel> labels;
  final EpubNavigationContent content;

  const EpubNavigationPageTarget({
    this.id,
    this.value,
    required this.type,
    this.classType,
    this.playOrder,
    required this.labels,
    required this.content,
  });

  EpubNavigationPageTarget copyWith({
    String? id,
    String? value,
    EpubNavigationPageTargetType? type,
    String? classType,
    String? playOrder,
    List<EpubNavigationLabel>? labels,
    EpubNavigationContent? content,
  }) {
    return EpubNavigationPageTarget(
      id: id ?? this.id,
      value: value ?? this.value,
      type: type ?? this.type,
      classType: classType ?? this.classType,
      playOrder: playOrder ?? this.playOrder,
      labels: labels ?? this.labels,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
      'type': type.index,
      'classType': classType,
      'playOrder': playOrder,
      'labels': labels.map((x) => x.toMap()).toList(),
      'content': content.toMap(),
    };
  }

  factory EpubNavigationPageTarget.fromMap(Map<String, dynamic> map) {
    return EpubNavigationPageTarget(
      id: map['id'],
      value: map['value'],
      type: EpubNavigationPageTargetType.values[map['type'] ?? 0],
      classType: map['classType'],
      playOrder: map['playOrder'],
      labels: List<EpubNavigationLabel>.from(
          map['labels']?.map((x) => EpubNavigationLabel.fromMap(x)) ??
              const []),
      content: EpubNavigationContent.fromMap(map['content']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationPageTarget.fromJson(String source) =>
      EpubNavigationPageTarget.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubNavigationPageTarget(id: $id, value: $value, type: $type, classType: $classType, playOrder: $playOrder, labels: $labels, content: $content)';
  }

  @override
  List<Object> get props {
    return [
      id ?? 'no id',
      value ?? 'no value',
      type,
      classType ?? 'no classType',
      playOrder ?? 'no playOrder',
      labels,
      content,
    ];
  }
}
