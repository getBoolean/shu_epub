part of shu_epub.models;

/// Navigation Information - Contains an informative comment about a
/// [EpubNavigationMap], [EpubNavigationPageList], or [EpubNavigationList]
/// in various media for presentation to the user.
class EpubNavigationInfo extends Equatable {
  final String? text;
  final EpubNavigationDocumentImage? image;

  const EpubNavigationInfo({
    this.text,
    this.image,
  });

  EpubNavigationInfo copyWith({
    String? text,
    EpubNavigationDocumentImage? image,
  }) {
    return EpubNavigationInfo(
      text: text ?? this.text,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'image': image?.toMap(),
    };
  }

  factory EpubNavigationInfo.fromMap(Map<String, dynamic> map) {
    return EpubNavigationInfo(
      text: map['text'],
      image: map['image'] != null
          ? EpubNavigationDocumentImage.fromMap(map['image'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationInfo.fromJson(String source) =>
      EpubNavigationInfo.fromMap(json.decode(source));

  @override
  String toString() => 'EpubNavigationInfo(text: $text, image: $image)';

  @override
  List<Object> get props => [text ?? 'no text', image ?? 'no image'];
}
