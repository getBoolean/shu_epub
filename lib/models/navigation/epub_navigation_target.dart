part of shu_epub.models;

/// Navigation Target - contains description(s) of target, as well as a pointer
/// to [EpubNavigationTarget.content]. [EpubNavigationTarget]s are the
/// equivalent of [EpubNavigationMap.navigationPoints] for use in
/// [EpubNavigation.navigationLists].
class EpubNavigationTarget extends Equatable {
  final String id;

  /// Describes the kind of structure this target represents, using its dtbook
  /// element name, e.g., note.
  final String? classType;

  /// A positive integer representing the numeric value associated with the
  /// [EpubNavigationTarget].
  final String? value;

  final EpubNavigationContent content;

  /// Description(s) of this target.
  ///
  /// Should have at least one item
  final List<EpubNavigationLabel> navigationLabels;

  const EpubNavigationTarget({
    required this.id,
    this.classType,
    this.value,
    required this.content,
    required this.navigationLabels,
  });

  EpubNavigationTarget copyWith({
    String? id,
    String? classType,
    String? value,
    EpubNavigationContent? content,
    List<EpubNavigationLabel>? navigationLabels,
  }) {
    return EpubNavigationTarget(
      id: id ?? this.id,
      classType: classType ?? this.classType,
      value: value ?? this.value,
      content: content ?? this.content,
      navigationLabels: navigationLabels ?? this.navigationLabels,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'classType': classType,
      'value': value,
      'content': content.toMap(),
      'navigationLabels': navigationLabels.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigationTarget.fromMap(Map<String, dynamic> map) {
    return EpubNavigationTarget(
      id: map['id'] ?? '',
      classType: map['classType'],
      value: map['value'],
      content: EpubNavigationContent.fromMap(map['content']),
      navigationLabels: List<EpubNavigationLabel>.from(map['navigationLabels']?.map((x) => EpubNavigationLabel.fromMap(x)) ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationTarget.fromJson(String source) =>
      EpubNavigationTarget.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubNavigationTarget(id: $id, classType: $classType, value: $value, content: $content, navigationLabels: $navigationLabels)';
  }

  @override
  List<Object> get props {
    return [
      id,
      classType ?? 'no classType',
      value ?? 'no value',
      content,
      navigationLabels,
    ];
  }
}
