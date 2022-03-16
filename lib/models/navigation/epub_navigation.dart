part of shu_epub.models;

class EpubNavigation extends Equatable {
  static const String namespace = 'http://www.daisy.org/z3986/2005/ncx/';

  final String version;
  final String language;
  final EpubNavigationHead head;
  final EpubNavigationDocumentTitle docTitle;
  final List<EpubNavigationDocumentAuthor> docAuthors;

  /// navInfo*, navLabel*, navPoint+
  final EpubNavigationMap navigationMap;

  const EpubNavigation({
    required this.version,
    required this.language,
    required this.head,
    required this.docTitle,
    required this.docAuthors,
    required this.navigationMap,
  });

  EpubNavigation copyWith({
    String? version,
    String? language,
    EpubNavigationHead? head,
    EpubNavigationDocumentTitle? docTitle,
    List<EpubNavigationDocumentAuthor>? docAuthors,
    EpubNavigationMap? navigationMap,
  }) {
    return EpubNavigation(
      version: version ?? this.version,
      language: language ?? this.language,
      head: head ?? this.head,
      docTitle: docTitle ?? this.docTitle,
      docAuthors: docAuthors ?? this.docAuthors,
      navigationMap: navigationMap ?? this.navigationMap,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'version': version,
      'language': language,
      'head': head.toMap(),
      'docTitle': docTitle.toMap(),
      'docAuthors': docAuthors.map((docAuthor) => docAuthor.toMap()),
      'navigationMap': navigationMap.toMap(),
    };
  }

  factory EpubNavigation.fromMap(Map<String, dynamic> map) {
    return EpubNavigation(
      version: map['version'] ?? '',
      language: map['language'] ?? '',
      head: EpubNavigationHead.fromMap(map['head']),
      docTitle: EpubNavigationDocumentTitle.fromMap(map['docTitle']),
      docAuthors: List<EpubNavigationDocumentAuthor>.from(
        map['docAuthors'].map((x) => EpubNavigationDocumentAuthor.fromMap(x)),
      ),
      navigationMap: EpubNavigationMap.fromMap(map['navigationMap']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigation.fromJson(String source) =>
      EpubNavigation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubNavigation(version: $version, language: $language, head: $head, docTitle: $docTitle, docAuthor: $docAuthors, navigationMap: $navigationMap)';
  }

  @override
  List<Object> get props {
    return [
      version,
      language,
      head,
      docTitle,
      docAuthors,
      navigationMap,
    ];
  }
}
