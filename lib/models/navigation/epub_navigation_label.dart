part of shu_epub.models;

/// Navigation Label - Contains a description of a given
/// [EpubNavigationMap], [EpubNavigationPoint], [EpubNavigationList], or
/// [EpubNavigationTarget] in various media for presentation to the user.
/// 
/// Can be repeated so descriptions can be provided in multiple languages. 
class EpubNavigationLabel extends Equatable {
  final List<String> text;
  final List<EpubNavigationDocumentImage> images;

  const EpubNavigationLabel({
    required this.text,
    required this.images,
  });

  EpubNavigationLabel copyWith({
    List<String>? text,
    List<EpubNavigationDocumentImage>? images,
  }) {
    return EpubNavigationLabel(
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

  factory EpubNavigationLabel.fromMap(Map<String, dynamic> map) {
    return EpubNavigationLabel(
      text: List<String>.from(map['text'] ?? const []),
      images: List<EpubNavigationDocumentImage>.from(
          map['images']?.map((x) => EpubNavigationDocumentImage.fromMap(x)) ??
              const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationLabel.fromJson(String source) =>
      EpubNavigationLabel.fromMap(json.decode(source));

  @override
  String toString() => 'EpubNavigationLabel(text: $text, images: $images)';

  @override
  List<Object> get props => [text, images];
}
