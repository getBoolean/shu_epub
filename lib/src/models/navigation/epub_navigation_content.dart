part of shu_epub.models;

/// Content Element - pointer into XML to beginning of navPoint.
class EpubNavigationContent extends Equatable {
  static const elementName = 'content';

  final String? source;
  final String? id;

  /// Create an [EpubNavigationContent] object from the content XmlElement.
  ///
  /// Throws [EpubException] if the content element is not the root node
  factory EpubNavigationContent.fromXmlElement(XmlElement contentElement) {
    return EpubNavigationContentReader.fromXmlElement(contentElement);
  }

  factory EpubNavigationContent.fromString(String contentString) {
    return EpubNavigationContentReader.fromString(contentString);
  }

  /// Create an instance of [EpubNavigationContent] from the [Uint8List] data
  /// of the content element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the content element
  factory EpubNavigationContent.fromData(Uint8List contentData) {
    return EpubNavigationContentReader.fromData(contentData);
  }

  const EpubNavigationContent({
    this.source,
    this.id,
  });

  EpubNavigationContent copyWith({
    String? source,
    String? id,
  }) {
    return EpubNavigationContent(
      source: source ?? this.source,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'source': source,
      'id': id,
    };
  }

  factory EpubNavigationContent.fromMap(Map<String, dynamic> map) {
    return EpubNavigationContent(
      source: map['source'] ?? '',
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationContent.fromJson(String source) =>
      EpubNavigationContent.fromMap(json.decode(source));

  @override
  String toString() => 'EpubNavigationContent(source: $source, id: $id)';

  @override
  List<Object> get props => [source ?? 'no source', id ?? 'no id'];
}
