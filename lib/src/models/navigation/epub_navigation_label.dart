part of shu_epub.models;

/// Navigation Label - Contains a description of a given
/// [EpubNavigationMap], [EpubNavigationPoint], [EpubNavigationList], or
/// [EpubNavigationTarget] in various media for presentation to the user.
///
/// Can be repeated so descriptions can be provided in multiple languages.
class EpubNavigationLabel extends Equatable {
  final String? text;
  final String? language;
  final EpubNavigationImage? image;

  const EpubNavigationLabel({
    this.text,
    this.language,
    this.image,
  });

  EpubNavigationLabel copyWith({
    String? text,
    String? language,
    EpubNavigationImage? image,
  }) {
    return EpubNavigationLabel(
      text: text ?? this.text,
      language: language ?? this.language,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'language': language,
      'image': image?.toMap(),
    };
  }

  factory EpubNavigationLabel.fromMap(Map<String, dynamic> map) {
    return EpubNavigationLabel(
      text: map['text'],
      language: map['language'],
      image: map['image'] != null
          ? EpubNavigationImage.fromMap(map['image'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationLabel.fromJson(String source) =>
      EpubNavigationLabel.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubNavigationLabel(text: $text, language: $language, image: $image)';

  @override
  List<Object> get props =>
      [text ?? 'no text', language ?? 'no language', image ?? 'no image'];
}
