part of shu_epub.features.package.data;

class EpubSpine extends Equatable {
  static const elementName = 'spine';
  
  /// The value is the the id attribute value of the required NCX (`.ncx` document
  /// listed in [EpubManifest.items]
  final String? tocId;

  /// The order of this list determines the reading order.
  ///
  /// It should not be an empty list.
  ///
  /// Each [EpubSpineItemRef] in spine must not reference media types other than OPS
  /// Content Documents (or documents whose fallback chain includes an OPS
  /// Content Document). An OPS Content Document must be of one of the
  /// following media types: `application/xhtml+xml`, `application/x-dtbook+xml`,
  /// the deprecated `text/x-oeb1-document`, and Out-Of-Line XML Island (with
  /// required `fallback`.) When a document with a media type not from this
  /// list (or a document whose `fallback` chain doesn't include a document
  /// with a media type from this list) is referenced in spine, Reading
  /// Systems **must** not include it as part of the spine.
  ///
  /// As items appearing in the spine must either be OPS Content Documents or
  /// items with a fallback chain that includes an OPS Content, it is possible
  /// to have a fallback chain for a spine item that "falls over" another OPS
  /// Core Media type. For example, a spine itemref could reference a PDF document,
  /// that falls back to a PNG image, that in turn falls back to a OPS XHTML Content
  /// Document. It is valid for this item to appear in the spine because the fallback
  /// chain includes (in this case terminates with) an OPS Content Document.
  ///
  /// In addition, a specific spine item (from the perspective of its `id` attribute
  /// value in [EpubPackage.manifest]) must not appear more than once in spine.
  ///
  /// All OPS Content Documents that are part of the publication (i.e. are listed in the manifest)
  /// which are potentially reachable by any reference mechanism allowed in this specification
  /// must be included in the spine. Such reference mechanisms include, as a partial list,
  /// hypertext links within OPS Content Documents, and references by the NCX, Tours and Guide.
  ///
  /// TODO(@getBoolean): Provide callback for user of this library to implement the below note.
  ///
  /// Should a Reading System encounter, by such reference, an OPS Content
  /// Document not listed in spine as required in this specification, the Reading System **should**
  /// add it to EPUB spine (the placement at the discretion of the Reading System) and assign the
  /// value of the linear attribute to "no" (see next.)
  ///
  /// For each itemref, the publication author may specify the optional linear attribute to designate
  /// whether the associated OPS Content Document is primary(`linear`=`true`, which is the default
  /// when linear is not present) or auxiliary (`linear`=`false`.) At least one [EpubSpineItemRef]
  /// in spine must be declared primary (linear=true).
  ///
  /// The Reader System may choose to display auxiliary content differently than primary content.
  /// They may also choose to treat all auxiliary content as primary content.
  ///
  /// The first primary item in itemRefs is the beginning of the main reading order of the publication.
  /// Successive primary OPS Content Documents form the remainder of the main reading order in the
  /// same order given in [EpubSpine.itemRefs]
  ///
  /// Note about "next-page" functionality: When at the end of one primary OPS Content Document,
  /// the Reading System should go to the next primary [EpubSpineItemRef] in [EpubSpine.itemRefs]
  ///
  /// The auxiliary ([EpubSpineItemRef.isAuxiliary]) content documents will be rendered by such Reading Systems, upon activation
  /// (such as through a hypertext link or entry in NCX), in some manner distinct from the main
  /// reading order. It is important that the publication author provide the necessary references
  /// to the auxiliary content documents, otherwise this content might not be reachable in some
  /// auxiliary-aware Reading Systems.
  ///
  /// http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.4
  final List<EpubSpineItemRef> itemRefs;

  /// Reading order of the EPUB.
  ///
  /// This filters out auxiliary items.
  ///
  /// Arguments:
  /// - `includeAuxiliary` Auxiliary items may be optionally treated as primary items. If left as false,
  /// (the default), the auxiliary content documents should be rendered upon activation (such as through
  /// a hypertext link or entry in NCX), in some manner distinct from the main reading order
  List<EpubSpineItemRef> getReadingOrder({
    bool includeAuxiliary = false,
  }) {
    if (includeAuxiliary) {
      return itemRefs;
    }

    return itemRefs.where((itemRef) => itemRef.isPrimary).toList();
  }

  /// Create an [EpubSpine] object from the spine XmlElement.
  ///
  /// Throws [EpubException] if the spine element is not the root node
  factory EpubSpine.fromXmlElement(XmlElement spineElement) {
    return EpubSpineReader.fromXmlElement(spineElement);
  }
  
  /// Create an instance of [EpubSpine] from the [String] representation
  /// of the spine element
  ///
  /// Throws [EpubException] if the string does not have the spine element
  factory EpubSpine.fromString(String spineString) {
    return EpubSpineReader.fromString(spineString);
  }
  
  /// Create an instance of [EpubSpine] from the [Uint8List] data
  /// of the spine element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the spine element
  factory EpubSpine.fromData(Uint8List spineData) {
    return EpubSpineReader.fromData(spineData);
  }

  const EpubSpine({
    this.tocId,
    this.itemRefs = const [],
  });

  EpubSpine copyWith({
    String? tocId,
    List<EpubSpineItemRef>? itemRefs,
  }) {
    return EpubSpine(
      tocId: tocId ?? this.tocId,
      itemRefs: itemRefs ?? this.itemRefs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tocId': tocId,
      'itemRefs': itemRefs.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubSpine.zero() {
    return EpubSpine(tocId: '', itemRefs: []);
  }

  factory EpubSpine.fromMap(Map<String, dynamic> map) {
    return EpubSpine(
      tocId: map['tocId'] ?? '',
      itemRefs: List<EpubSpineItemRef>.from(
          map['itemRefs']?.map(EpubSpineItemRef.fromMap)),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubSpine.fromJson(String source) =>
      EpubSpine.fromMap(json.decode(source));

  @override
  String toString() => 'EpubSpine(tocId: $tocId, itemRefs: $itemRefs)';

  @override
  List<Object> get props => [tocId ?? 'no tocId', itemRefs];
}
