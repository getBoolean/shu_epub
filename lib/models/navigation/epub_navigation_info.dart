part of shu_epub.models;

/// Navigation Information - Contains an informative comment about a 
/// [EpubNavigationMap], [EpubNavigationPageList], or [EpubNavigationList]
/// in various media for presentation to the user.
class EpubNavigationInfo extends Equatable {
  final List<String> text;
  final List<EpubNavigationDocumentImage> images;

  const EpubNavigationInfo({
    required this.text,
    required this.images,
  });

  EpubNavigationInfo copyWith({
    List<String>? text,
    List<EpubNavigationDocumentImage>? images,
  }) {
    return EpubNavigationInfo(
      text: text ?? this.text,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'images': images.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigationInfo.fromMap(Map<String, dynamic> map) {
    return EpubNavigationInfo(
      text: List<String>.from(map['text'] ?? const []),
      images: List<EpubNavigationDocumentImage>.from(
          map['images']?.map((x) => EpubNavigationDocumentImage.fromMap(x)) ??
              const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationInfo.fromJson(String source) =>
      EpubNavigationInfo.fromMap(json.decode(source));

  @override
  String toString() => 'EpubNavigationInfo(text: $text, images: $images)';

  @override
  List<Object> get props => [text, images];
}
