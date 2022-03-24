part of shu_epub.features.package.data;

class EpubManifestItem extends Equatable {
  final String id;
  final String href;
  final String mediaType;

  /// If a `fallback` attribute points to an [EpubManifestItem]'s `id`
  /// that also has a `fallback` attribute, a Reading System **must** continue
  /// down the fallback chain until it reaches a reference to an [EpubManifestItem]
  /// with a media type it can display (or as specified below, it reaches
  /// an item with a `fallback-style` attribute). A Reading System **may**
  /// continue further, and **may** display any item from the chain. In the
  /// absence of element-specific (i.e. `img` and `object`) fallback information,
  /// every [EpubManifestItem] in a publication that does not have one of the OPS Core Media
  /// Types **must**, directly or indirectly, specify a fallback to an item
  /// that does have one of the OPS Core Media Types (or as specified
  /// below, an [EpubManifestItem] with a `fallback-style` attribute).
  ///
  /// Fallback chains **must** terminate; circular references are not permitted.
  /// Nevertheless, Reading Systems **should not** fail catastrophically if
  /// they encounter such a loop.
  final String? fallback;

  const EpubManifestItem({
    required this.id,
    required this.href,
    required this.mediaType,
    this.fallback,
  });

  EpubManifestItem copyWith({
    String? id,
    String? href,
    String? mediaType,
    String? fallback,
  }) {
    return EpubManifestItem(
      id: id ?? this.id,
      href: href ?? this.href,
      mediaType: mediaType ?? this.mediaType,
      fallback: fallback ?? this.fallback,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'href': href,
      'mediaType': mediaType,
      'fallback': fallback,
    };
  }

  factory EpubManifestItem.fromMap(Map<String, dynamic> map) {
    return EpubManifestItem(
      id: map['id'] ?? '',
      href: map['href'] ?? '',
      mediaType: map['mediaType'] ?? '',
      fallback: map['fallback'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubManifestItem.fromJson(String source) =>
      EpubManifestItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubManifestItem(id: $id, href: $href, mediaType: $mediaType, fallback: $fallback)';
  }

  @override
  List<Object> get props {
    return [
      id,
      href,
      mediaType,
      fallback ?? 'no fallback',
    ];
  }
}

/// An item that specifies a resource that is an Out-Of-Line XML Island
/// (an XML document that is not authored in a Preferred Vocabulary).
/// An item is an Out-Of-Line XML Island if:
///
/// 1. It specifies a resource that is an XML document not authored in
/// a Preferred Vocabulary (i.e. an XML document with a media-type
/// that is neither application/xhtml+xml, application/x-dtbook+xml
/// nor the deprecated text/x-eob1-document); **OR**
/// 2. It specifies a resource that is an XML document authored in
/// a Preferred Vocabulary and incorporates the use of Extended Modules.
///
/// http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.3.1.2
class EpubManifestItemOutOfLineXMLIsland extends EpubManifestItem {
  final String requiredNamespace;

  /// If the fallback-style attribute is specified, a Reading System
  /// may choose to process the Out-Of-Line XML Island (even though
  /// it can not natively process the vocabulary or Extended Modules
  /// used in the island) using the stylesheet specified by the
  /// `fallback-style` attribute's value which must contain a reference
  /// to the `id` of the [EpubManifestItem] containing an `htmlReference`
  /// to the stylesheet desired for the island.
  final String? fallbackStyle;

  /// List containing the name(s) of the Extended Modules used in the
  /// Out-of-Line XML Island.
  ///
  /// The names of the modules are not case-sensitive, unless specifically
  /// defined otherwise in the XML vocabulary specification. Spaces in
  /// module names must be replaced with `-` for listing in the
  /// required-modules attribute value. For XHTML, in the context of OPS,
  /// the Extended Modules include `ruby`, `forms`, `server-side-image-map`,
  /// and `intrinsic-events`.
  final List<String>? requiredModules;

  const EpubManifestItemOutOfLineXMLIsland({
    required String id,
    required String href,
    required String mediaType,
    required String? fallback,
    required this.requiredNamespace,
    this.fallbackStyle,
    this.requiredModules,
  }) : super(
          id: id,
          href: href,
          mediaType: mediaType,
          fallback: fallback,
        );

  @override
  EpubManifestItemOutOfLineXMLIsland copyWith({
    String? id,
    String? href,
    String? mediaType,
    String? fallback,
    String? requiredNamespace,
    String? fallbackStyle,
    List<String>? requiredModules,
  }) {
    return EpubManifestItemOutOfLineXMLIsland(
      id: id ?? this.id,
      href: href ?? this.href,
      mediaType: mediaType ?? this.mediaType,
      fallback: fallback ?? this.fallback,
      requiredNamespace: requiredNamespace ?? this.requiredNamespace,
      fallbackStyle: fallbackStyle ?? this.fallbackStyle,
      requiredModules: requiredModules ?? this.requiredModules,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'requiredNamespace': requiredNamespace,
      'id': id,
      'href': href,
      'mediaType': mediaType,
      'fallback': fallback,
      'fallbackStyle': fallbackStyle,
      'requiredModules': requiredModules,
    };
  }

  factory EpubManifestItemOutOfLineXMLIsland.fromMap(Map<String, dynamic> map) {
    return EpubManifestItemOutOfLineXMLIsland(
      id: map['id'] ?? '',
      href: map['href'] ?? '',
      mediaType: map['mediaType'] ?? '',
      fallback: map['fallback'],
      requiredNamespace: map['requiredNamespace'] ?? '',
      fallbackStyle: map['fallbackStyle'] ?? '',
      requiredModules: map['requiredModules'] != null
          ? List<String>.from(map['requiredModules'])
          : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory EpubManifestItemOutOfLineXMLIsland.fromJson(String source) =>
      EpubManifestItemOutOfLineXMLIsland.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubManifestItemOutOfLineXMLItem('
        'id: $id, href: $href, mediaType: $mediaType, fallback: $fallback '
        'requiredNamespace: $requiredNamespace '
        'fallbackStyle: $fallbackStyle '
        'requiredModules: $requiredModules'
        ')';
  }

  @override
  List<Object> get props {
    return [
      id,
      href,
      mediaType,
      fallback ?? 'no fallback',
      requiredNamespace,
      requiredModules ?? 'no required modules specified',
    ];
  }
}
