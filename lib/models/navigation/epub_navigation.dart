part of shu_epub.models;

/// Top Level NCX Container.
class EpubNavigation extends Equatable {
  /// XML Namespace of the `ncx` element
  static const String namespace = 'http://www.daisy.org/z3986/2005/ncx/';

  /// NCX Version. Only `2005-1` is supported.
  final String version;
  final String language;

  /// Contains all NCX metadata.
  final EpubNavigationHead head;

  /// The title of the document, required and must immediately follow head.
  final EpubNavigationDocumentTitle docTitle;

  /// List of authors of the document, immediately follows docTitle.
  final List<EpubNavigationDocumentAuthor> docAuthors;

  /// Navigation Structure - container for all of the NCX objects that are part
  /// of the hierarchical structure of the document.
  ///
  /// Provides navigational access to the major hierarchical structure of the publication.
  final EpubNavigationMap navigationMap;

  /// Page List -  Container for pagination information.
  final EpubNavigationPageList? pageList;

  /// List of [EpubNavigationList], essentially a flat version of
  /// [EpubNavigationMap].
  final List<EpubNavigationList> navigationLists;

  const EpubNavigation({
    required this.version,
    required this.language,
    required this.head,
    required this.docTitle,
    required this.docAuthors,
    required this.navigationMap,
    this.pageList,
    this.navigationLists = const [],
  });

  EpubNavigation copyWith({
    String? version,
    String? language,
    EpubNavigationHead? head,
    EpubNavigationDocumentTitle? docTitle,
    List<EpubNavigationDocumentAuthor>? docAuthors,
    EpubNavigationMap? navigationMap,
    EpubNavigationPageList? pageList,
    List<EpubNavigationList>? navigationLists,
  }) {
    return EpubNavigation(
      version: version ?? this.version,
      language: language ?? this.language,
      head: head ?? this.head,
      docTitle: docTitle ?? this.docTitle,
      docAuthors: docAuthors ?? this.docAuthors,
      navigationMap: navigationMap ?? this.navigationMap,
      pageList: pageList ?? this.pageList,
      navigationLists: navigationLists ?? this.navigationLists,
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
      'navigationLists': navigationLists.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigation.fromMap(Map<String, dynamic> map) {
    return EpubNavigation(
      version: map['version'] ?? '',
      language: map['language'] ?? '',
      head: EpubNavigationHead.fromMap(map['head']),
      docTitle: EpubNavigationDocumentTitle.fromMap(map['docTitle']),
      docAuthors: List<EpubNavigationDocumentAuthor>.from(map['docAuthors']
              ?.map((x) => EpubNavigationDocumentAuthor.fromMap(x)) ??
          const []),
      navigationMap: EpubNavigationMap.fromMap(map['navigationMap']),
      pageList: map['pageList'] != null
          ? EpubNavigationPageList.fromMap(map['pageList'])
          : null,
      navigationLists: List<EpubNavigationList>.from(
          map['navigationLists']?.map((x) => EpubNavigationList.fromMap(x)) ??
              const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigation.fromJson(String source) =>
      EpubNavigation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubNavigation(version: $version, language: $language, head: $head, docTitle: $docTitle, docAuthors: $docAuthors, navigationMap: $navigationMap, pageList: $pageList, navigationLists: $navigationLists)';
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
      pageList ?? 'no pageList element',
      navigationLists,
    ];
  }
}
