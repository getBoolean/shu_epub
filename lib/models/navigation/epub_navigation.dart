part of shu_epub.models;

class EpubNavigation extends Equatable {
  static const String namespace = 'http://www.daisy.org/z3986/2005/ncx/';

  final String version;
  final String language;
  final EpubNavigationHead head;
  final EpubNavigationDocumentTitle docTitle;
  final List<EpubNavigationDocumentAuthor> docAuthors;

  /// Provides navigational access to the major hierarchical structure of the publication
  final EpubNavigationMap navigationMap;

  final EpubNavigationPageList? pageList;

  // final List<EpubNavigationList> navigationLists;

  const EpubNavigation({
    required this.version,
    required this.language,
    required this.head,
    required this.docTitle,
    required this.docAuthors,
    required this.navigationMap,
    this.pageList,
  });

  EpubNavigation copyWith({
    String? version,
    String? language,
    EpubNavigationHead? head,
    EpubNavigationDocumentTitle? docTitle,
    List<EpubNavigationDocumentAuthor>? docAuthors,
    EpubNavigationMap? navigationMap,
    EpubNavigationPageList? pageList,
  }) {
    return EpubNavigation(
      version: version ?? this.version,
      language: language ?? this.language,
      head: head ?? this.head,
      docTitle: docTitle ?? this.docTitle,
      docAuthors: docAuthors ?? this.docAuthors,
      navigationMap: navigationMap ?? this.navigationMap,
      pageList: pageList ?? this.pageList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'version': version,
      'language': language,
      'head': head.toMap(),
      'docTitle': docTitle.toMap(),
      'docAuthors': docAuthors.map((x) => x.toMap()).toList(),
      'navigationMap': navigationMap.toMap(),
      'pageList': pageList?.toMap(),
    };
  }

  factory EpubNavigation.fromMap(Map<String, dynamic> map) {
    return EpubNavigation(
      version: map['version'] ?? '',
      language: map['language'] ?? '',
      head: EpubNavigationHead.fromMap(map['head']),
      docTitle: EpubNavigationDocumentTitle.fromMap(map['docTitle']),
      docAuthors: List<EpubNavigationDocumentAuthor>.from(map['docAuthors']?.map((x) => EpubNavigationDocumentAuthor.fromMap(x)) ?? const []),
      navigationMap: EpubNavigationMap.fromMap(map['navigationMap']),
      pageList: map['pageList'] != null ? EpubNavigationPageList.fromMap(map['pageList']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigation.fromJson(String source) =>
      EpubNavigation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubNavigation(version: $version, language: $language, head: $head, docTitle: $docTitle, docAuthors: $docAuthors, navigationMap: $navigationMap, pageList: $pageList)';
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
      pageList ?? 'no pageList',
    ];
  }
}
