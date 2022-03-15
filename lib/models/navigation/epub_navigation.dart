part of shu_epub.models;

class EpubNavigation extends Equatable {
  static const String namespace = 'http://www.daisy.org/z3986/2005/ncx/';

  final String version;
  final String language;
  final EpubNavigationHead head;
  final String docTitle;
  final String docAuthor;

  EpubNavigation({
    required this.version,
    required this.language,
    required this.head,
    required this.docTitle,
    required this.docAuthor,
  });

  EpubNavigation copyWith({
    String? version,
    String? language,
    EpubNavigationHead? head,
    String? docTitle,
    String? docAuthor,
  }) {
    return EpubNavigation(
      version: version ?? this.version,
      language: language ?? this.language,
      head: head ?? this.head,
      docTitle: docTitle ?? this.docTitle,
      docAuthor: docAuthor ?? this.docAuthor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'version': version,
      'language': language,
      'head': head.toMap(),
      'docTitle': docTitle,
      'docAuthor': docAuthor,
    };
  }

  factory EpubNavigation.fromMap(Map<String, dynamic> map) {
    return EpubNavigation(
      version: map['version'] ?? '',
      language: map['language'] ?? '',
      head: EpubNavigationHead.fromMap(map['head']),
      docTitle: map['docTitle'] ?? '',
      docAuthor: map['docAuthor'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigation.fromJson(String source) =>
      EpubNavigation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubNCXFile(version: $version, language: $language, head: $head, docTitle: $docTitle, docAuthor: $docAuthor)';
  }

  @override
  List<Object> get props => [version, language, head, docTitle, docAuthor];
}