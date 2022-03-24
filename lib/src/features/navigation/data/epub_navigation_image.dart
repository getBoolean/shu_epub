part of shu_epub.features.navigation.data;

/// Image Element - image that may accompany heading.
class EpubNavigationImage extends Equatable {
  static const elementName = 'img';

  final String? id;
  final String? classType;
  final String? source;

  /// Create an [EpubNavigationImage] object from the img XmlElement.
  ///
  /// Throws [EpubException] if the img element is not the root node
  factory EpubNavigationImage.fromXmlElement(XmlElement imgElement) {
    return EpubNavigationImageReader.fromXmlElement(imgElement);
  }

  factory EpubNavigationImage.fromString(String imgString) {
    return EpubNavigationImageReader.fromString(imgString);
  }

  /// Create an instance of [EpubNavigationImage] from the [Uint8List] data
  /// of the img element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the img element
  factory EpubNavigationImage.fromData(Uint8List imgData) {
    return EpubNavigationImageReader.fromData(imgData);
  }

  const EpubNavigationImage({
    this.id,
    this.classType,
    this.source,
  });

  factory EpubNavigationImage.zero() {
    return EpubNavigationImage(source: '');
  }

  EpubNavigationImage copyWith({
    String? id,
    String? classType,
    String? source,
  }) {
    return EpubNavigationImage(
      id: id ?? this.id,
      classType: classType ?? this.classType,
      source: source ?? this.source,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'classType': classType,
      'source': source,
    };
  }

  factory EpubNavigationImage.fromMap(Map<String, dynamic> map) {
    return EpubNavigationImage(
      id: map['id'],
      classType: map['classType'],
      source: map['source'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationImage.fromJson(String source) =>
      EpubNavigationImage.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubNavigationImage(id: $id, classType: $classType, source: $source)';

  @override
  List<Object> get props =>
      [id ?? 'no id', classType ?? 'no classType', source ?? 'no source'];
}
