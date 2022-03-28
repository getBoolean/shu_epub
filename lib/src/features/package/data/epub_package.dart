part of shu_epub.features.package.data;

/// A publication conforming to this specification must include exactly one XML OPF
/// Package Document, which specifies the OPS Content Documents, images, and other
/// objects that make up the OPS Publication and how they relate to each other.
///
/// The OPF Package Document should be named ending in the extension `.opf`, in
/// order to make it readily identifiable within the group of files making up
/// the publication. The OPS Package Document is of MIME media type
/// `application/oebps-package+xml`. This specification does not define means
/// for physically bundling files together to make one data transfer object
/// (such as using zip or tar); the Open Container Format (OCF) specifies
/// this functionality.
///
/// This specification neither precludes nor requires the inclusion of the OPF Package Schema in a Publication.
class EpubPackage extends Equatable {
  static const kPackageFileMimeType = 'application/oebps-package+xml';
  static const elementName = 'package';
  static const namespace = 'http://www.idpf.org/2007/opf';

  final String? epubVersion;

  /// A unique identifier for the OPS Publication as a whole. This should NOT
  /// be relied upon to be unique across all EPUB publications.
  ///
  /// The uniqueIdentifier field's value specifies which [EpubPublicationMetadata.identifiers]
  /// described in Section 2.2.10, provides the package's preferred, or primary, identifier.
  ///
  /// Notwithstanding the requirement for uniqueness, Reading Systems must not
  /// fail catastrophically if they encounter two distinct packages with the same
  /// purportedly unique primary identifier.
  final String? uniqueIdentifier;

  /// Publication metadata (title, author, publisher, etc.).
  final EpubPublicationMetadata? publicationMetadata;

  /// A list of files (documents, images, style sheets, etc.) that make up the publication.
  /// The manifest also includes fallback declarations for files of types not supported by
  /// this specification.
  ///
  /// The required manifest must provide a list of all the files that are part of the
  /// publication (e.g. Content Documents, style sheets, image files, any embedded
  /// font files, any included schemas).
  ///
  /// All DTDs and external entities (including, but not limited to, external DTD
  /// references) referenced by XML documents listed in the package manifest are
  /// considered part of the publication and thus must also be listed in the manifest.
  /// As an exception to that rule, DTDs of certain core document types do not need to
  /// be included. The list of DTDs that do need to be included in the manifest is:
  ///
  /// 1. SVG 1.1 DTD (www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd)
  /// 2. XHTML 1.1 DTD (www.w3.org/TR/xhtml11/DTD/xhtml11.dtd)
  /// 3. DTBook DTD (www.daisy.org/z3986/2005/dtbook-2005-2.dtd)
  /// 4. NCX DTD (www.daisy.org/z3986/2005/ncx-2005-1.dtd)
  ///
  /// The manifest element **must** contain one or more item elements.Each item describes
  /// a document, an image file, a style sheet, or other component that is considered
  /// part of the publication. The manifest must not include item elements referring
  /// to the file or files that make up the OPF Package Document.
  ///
  /// TODO(@getBoolean): Support Epub 2 [Out-Of-Line XML Islands](http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.3.1.2)
  final EpubManifest? manifest;

  /// An arrangement of documents providing a linear reading order.
  final EpubSpine? spine;

  /// A set of references to fundamental structural features of the publication, such
  ///
  /// as table of contents, foreword, bibliography, etc.
  /// Within the package there may be one guide element, containing one or more reference
  /// elements. The guide element identifies fundamental structural components of the
  /// publication, to enable Reading Systems to provide convenient access to them.
  ///
  /// http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.6
  final EpubGuide? guide;

  /// Deprecated in Epub 2.0.1
  ///
  /// A set of alternate reading sequences through the publication, such as selective views
  /// for various reading purposes, reader expertise levels, etc.
  final EpubTours? tours;

  factory EpubPackage.fromArchiveFile(ArchiveFile archiveFile) {
    return EpubPackageReader.fromArchiveFile(archiveFile);
  }

  /// Create an [EpubPackage] object from the package XmlElement.
  ///
  /// Throws [EpubException] if the package element is not the root node
  factory EpubPackage.fromXmlElement(XmlElement packageElement) {
    return EpubPackageReader.fromXmlElement(packageElement);
  }

  /// Create an instance of [EpubPackage] from the [String] representation
  /// of the package element
  ///
  /// Throws [EpubException] if the string does not have the package element
  factory EpubPackage.fromXmlString(String packageString) {
    return EpubPackageReader.fromXmlString(packageString);
  }

  /// Create an instance of [EpubPackage] from the [Uint8List] data
  /// of the package element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the package element
  factory EpubPackage.fromData(Uint8List packageData) {
    return EpubPackageReader.fromData(packageData);
  }

  // GENERATED DO NOT MODOFY

  const EpubPackage({
    this.epubVersion,
    this.uniqueIdentifier,
    this.publicationMetadata,
    this.manifest,
    this.spine,
    this.guide,
    this.tours,
  });

  EpubPackage copyWith({
    String? epubVersion,
    String? uniqueIdentifier,
    EpubPublicationMetadata? publicationMetadata,
    EpubManifest? manifest,
    EpubSpine? spine,
    EpubGuide? guide,
    EpubTours? tours,
  }) {
    return EpubPackage(
      epubVersion: epubVersion ?? this.epubVersion,
      uniqueIdentifier: uniqueIdentifier ?? this.uniqueIdentifier,
      publicationMetadata: publicationMetadata ?? this.publicationMetadata,
      manifest: manifest ?? this.manifest,
      spine: spine ?? this.spine,
      guide: guide ?? this.guide,
      tours: tours ?? this.tours,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'epubVersion': epubVersion,
      'uniqueIdentifier': uniqueIdentifier,
      'publicationMetadata': publicationMetadata?.toMap(),
      'manifest': manifest?.toMap(),
      'spine': spine?.toMap(),
      'guide': guide?.toMap(),
      'tours': tours?.toMap(),
    };
  }

  factory EpubPackage.fromMap(Map<String, dynamic> map) {
    return EpubPackage(
      epubVersion: map['epubVersion'],
      uniqueIdentifier: map['uniqueIdentifier'],
      publicationMetadata: map['publicationMetadata'] != null
          ? EpubPublicationMetadata.fromMap(map['publicationMetadata'])
          : null,
      manifest: map['manifest'] != null
          ? EpubManifest.fromMap(map['manifest'])
          : null,
      spine: map['spine'] != null ? EpubSpine.fromMap(map['spine']) : null,
      guide: map['guide'] != null ? EpubGuide.fromMap(map['guide']) : null,
      tours: map['tours'] != null ? EpubTours.fromMap(map['tours']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubPackage.fromJson(String source) =>
      EpubPackage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubPackage(epubVersion: $epubVersion, uniqueIdentifier: $uniqueIdentifier, publicationMetadata: $publicationMetadata, manifest: $manifest, spine: $spine, guide: $guide, tours: $tours)';
  }

  @override
  List<Object> get props {
    return [
      epubVersion ?? 'no epubVersion',
      uniqueIdentifier ?? 'no uniqueIdentifier',
      publicationMetadata ?? 'no publicationMetadata',
      manifest ?? 'no manifest',
      spine ?? 'no spine',
      guide ?? 'no guide',
      tours ?? 'no tours',
    ];
  }
}
