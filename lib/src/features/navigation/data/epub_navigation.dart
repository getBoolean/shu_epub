part of shu_epub.features.navigation.data;

/// Top Level NCX Container.
class EpubNavigation extends Equatable {
  /// XML Namespace of the `ncx` element
  static const String namespace = 'http://www.daisy.org/z3986/2005/ncx/';
  static const elementName = 'ncx';

  /// NCX Version. Only `2005-1` is supported.
  final String? version;

  final String? language;

  /// Contains all NCX metadata.
  final EpubNavigationHead? head;

  /// The title of the document, required and must immediately follow head.
  final EpubNavigationDocumentTitle? docTitle;

  /// List of authors of the document, immediately follows docTitle.
  final List<EpubNavigationDocumentAuthor> docAuthors;

  /// Navigation Structure - container for all of the NCX objects that are part
  /// of the hierarchical structure of the document.
  ///
  /// Provides navigational access to the major hierarchical structure of the publication.
  final EpubNavigationMap? navigationMap;

  /// Page List -  Container for pagination information.
  final EpubNavigationPageList? pageList;

  /// List of [EpubNavigationList], essentially a flat version of
  /// [EpubNavigationMap].
  final List<EpubNavigationList> navigationLists;

  /// Create an [EpubNavigation] object from the ncx XmlElement.
  ///
  /// Throws [EpubException] if the navigation element is not the root node
  factory EpubNavigation.fromXmlElement(XmlElement navigationElement) {
    return EpubNavigationReader.fromXmlElement(navigationElement);
  }

  /// Create an instance of [EpubNavigation] from the [String] representation
  /// of the navigation element
  ///
  /// Throws [EpubException] if the string does not have the navigation element
  factory EpubNavigation.fromXmlString(String navigationString) {
    return EpubNavigationReader.fromXmlString(navigationString);
  }

  /// Create an instance of [EpubNavigation] from the [Uint8List] data
  /// of the navigation element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the navigation element
  factory EpubNavigation.fromData(Uint8List navigationData) {
    return EpubNavigationReader.fromData(navigationData);
  }

  const EpubNavigation({
    this.version,
    this.language,
    this.head,
    this.docTitle,
    this.docAuthors = const [],
    this.navigationMap,
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
      'head': head?.toMap(),
      'docTitle': docTitle?.toMap(),
      'docAuthors': docAuthors.map((x) => x.toMap()).toList(),
      'navigationMap': navigationMap?.toMap(),
      'pageList': pageList?.toMap(),
      'navigationLists': navigationLists.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigation.fromMap(Map<String, dynamic> map) {
    return EpubNavigation(
      version: map['version'],
      language: map['language'],
      head:
          map['head'] == null ? null : EpubNavigationHead.fromMap(map['head']),
      docTitle: map['docTitle'] == null
          ? null
          : EpubNavigationDocumentTitle.fromMap(map['docTitle']),
      docAuthors: List<EpubNavigationDocumentAuthor>.from(map['docAuthors']
              // ignore: unnecessary_lambdas
              ?.map((e) => EpubNavigationDocumentAuthor.fromMap(e)) ??
          const []),
      navigationMap: map['navigationMap'] == null
          ? null
          : EpubNavigationMap.fromMap(map['navigationMap']),
      pageList: map['pageList'] != null
          ? EpubNavigationPageList.fromMap(map['pageList'])
          : null,
      navigationLists: List<EpubNavigationList>.from(
          // ignore: unnecessary_lambdas
          map['navigationLists']?.map((e) => EpubNavigationList.fromMap(e)) ??
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
      version ?? 'no version',
      language ?? 'no language specified',
      head ?? 'no head element',
      docTitle ?? 'no title element',
      docAuthors,
      navigationMap ?? 'no navMap element',
      pageList ?? 'no pageList element',
      navigationLists,
    ];
  }
}
