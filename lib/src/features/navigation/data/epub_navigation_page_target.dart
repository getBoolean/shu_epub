part of shu_epub.features.navigation.data;

/// Page Target -  Container for text, image, and content elements
/// containing navigational information for pages.  The "value" attribute is a
/// positive integer representing the numeric value associated with a page.
/// Combination of values of type and value attributes must be unique, when
/// value attribute is present.
@Immutable()
class EpubNavigationPageTarget extends EquatableXml {
  static const elementName = 'pageTarget';

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
  final EpubNavigationContent? content;

  /// Create an [EpubNavigationPageTarget] object from the pageTarget XmlElement.
  ///
  /// Throws [EpubException] if the pageTarget element is not the root node
  factory EpubNavigationPageTarget.fromXmlElement(
      XmlElement pageTargetElement) {
    return EpubNavigationPageTargetReader.fromXmlElement(pageTargetElement);
  }

  factory EpubNavigationPageTarget.fromXmlString(String pageTargetString) {
    return EpubNavigationPageTargetReader.fromXmlString(pageTargetString);
  }

  /// Create an instance of [EpubNavigationPageTarget] from the [Uint8List] data
  /// of the pageTarget element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the pageTarget element
  factory EpubNavigationPageTarget.fromData(Uint8List pageTargetData) {
    return EpubNavigationPageTargetReader.fromData(pageTargetData);
  }

  const EpubNavigationPageTarget({
    this.id,
    this.value,
    this.type = EpubNavigationPageTargetType.normal,
    this.classType,
    this.playOrder,
    this.labels = const [],
    this.content,
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
      'type': type.name,
      'classType': classType,
      'playOrder': playOrder,
      'labels': labels.map((x) => x.toMap()).toList(),
      'content': content?.toMap(),
    };
  }

  factory EpubNavigationPageTarget.fromMap(Map<String, dynamic> map) {
    return EpubNavigationPageTarget(
      id: map['id'],
      value: map['value'],
      type: EpubNavigationPageTargetType.values.byName(map['type']),
      classType: map['classType'],
      playOrder: map['playOrder'],
      labels: List<EpubNavigationLabel>.from(
          // ignore: unnecessary_lambdas
          map['labels']?.map((e) => EpubNavigationLabel.fromMap(e))),
      content: map['content'] != null
          ? EpubNavigationContent.fromMap(map['content'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationPageTarget.fromJson(String source) =>
      EpubNavigationPageTarget.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubNavigationPageTarget(id: $id, value: $value, type: ${type.name}, classType: $classType, playOrder: $playOrder, labels: $labels, content: $content)';
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
      content ?? 'no content',
    ];
  }

  @override
  String toXmlString() => '<$elementName'
      '${id != null ? ' id="$id"' : ''}'
      '${classType != null ? ' class="$classType"' : ''}'
      '${value != null ? ' value="$value"' : ''}'
      ' type="${type.name}"'
      '${playOrder != null ? ' playOrder="$playOrder"' : ''}'
      '>'
      '${content != null ? content!.toXmlString() : ''}'
      '${labels.map((label) => label.toXmlString()).join('')}'
      '</$elementName>';
}
