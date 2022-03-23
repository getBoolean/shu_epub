part of shu_epub.models;

/// Navigation Target - contains description(s) of target, as well as a pointer
/// to [EpubNavigationTarget.content]. [EpubNavigationTarget]s are the
/// equivalent of [EpubNavigationMap.navigationPoints] for use in
/// [EpubNavigation.navigationLists].
class EpubNavigationTarget extends Equatable {
  final String? id;

  /// A positive integer representing the numeric value associated with the
  /// [EpubNavigationTarget].
  final String? value;

  /// Describes the kind of structure this target represents, using its dtbook
  /// element name, e.g., note.
  final String? classType;

  /// Description(s) of this target.
  ///
  /// Should have at least one item
  final List<EpubNavigationLabel> labels;

  /// Pointer to XML element
  final EpubNavigationContent? content;

  /// Create an [EpubNavigationTarget] object from the navTarget XmlElement.
  ///
  /// Throws [EpubException] if the navTarget element is not the root node
  factory EpubNavigationTarget.fromXmlElement(XmlElement navTargetElement) {
    return EpubNavigationTargetReader.fromXmlElement(navTargetElement);
  }

  factory EpubNavigationTarget.fromString(String navTargetString) {
    return EpubNavigationTargetReader.fromString(navTargetString);
  }

  /// Create an instance of [EpubNavigationTarget] from the [Uint8List] data
  /// of the navTarget element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navTarget element
  factory EpubNavigationTarget.fromData(Uint8List navTargetData) {
    return EpubNavigationTargetReader.fromData(navTargetData);
  }

  const EpubNavigationTarget({
    this.id,
    this.classType,
    this.value,
    this.content,
    this.labels = const [],
  });

  EpubNavigationTarget copyWith({
    String? id,
    String? classType,
    String? value,
    EpubNavigationContent? content,
    List<EpubNavigationLabel>? labels,
  }) {
    return EpubNavigationTarget(
      id: id ?? this.id,
      classType: classType ?? this.classType,
      value: value ?? this.value,
      content: content ?? this.content,
      labels: labels ?? this.labels,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'classType': classType,
      'value': value,
      'content': content?.toMap(),
      'labels': labels.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigationTarget.fromMap(Map<String, dynamic> map) {
    return EpubNavigationTarget(
      id: map['id'],
      classType: map['classType'],
      value: map['value'],
      content: map['content'] != null
          ? EpubNavigationContent.fromMap(map['content'])
          : null,
      labels: List<EpubNavigationLabel>.from(
          map['labels']?.map(EpubNavigationLabel.fromMap)),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationTarget.fromJson(String source) =>
      EpubNavigationTarget.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubNavigationTarget(id: $id, classType: $classType, value: $value, content: $content, labels: $labels)';
  }

  @override
  List<Object> get props {
    return [
      id ?? 'no id',
      classType ?? 'no classType',
      value ?? 'no value',
      content ?? 'no content',
      labels,
    ];
  }
}
