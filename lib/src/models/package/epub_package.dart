part of shu_epub.models;

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

  /// Includes a unique identifier for the OPS Publication as a whole. This should NOT
  /// be relied upon to be unique across all EPUB publications.
  ///
  /// Excerpt From: http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.1
  ///
  /// The package element is the root element in an OPF Package Document; all other elements are nested within it.
  ///
  /// The package element must specify a value for its unique-identifier attribute.
  /// The unique-identifier attribute's value specifies which Dublin Core identifier
  /// element, described in Section 2.2.10, provides the package's preferred, or
  /// primary, identifier. The OPF Package Document's author is responsible for
  /// choosing a primary identifier that is unique to one and only one particular
  /// package (i.e., the set of files referenced from the package document's manifest).
  ///
  /// Notwithstanding the requirement for uniqueness, Reading Systems must not
  /// fail catastrophically if they encounter two distinct packages with the same
  /// purportedly unique primary identifier.
  final EpubPackageIdentity packageIdentity;

  /// Publication metadata (title, author, publisher, etc.).
  final EpubPublicationMetadata publicationMetadata;

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
  final EpubManifest manifest;

  /// An arrangement of documents providing a linear reading order.
  ///
  /// TODO(@getBoolean): Model, Implementation
  final EpubSpine spine;

  /// A set of references to fundamental structural features of the publication, such
  ///
  /// as table of contents, foreword, bibliography, etc.
  /// Within the package there may be one guide element, containing one or more reference
  /// elements. The guide element identifies fundamental structural components of the
  /// publication, to enable Reading Systems to provide convenient access to them.
  ///
  /// http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.6
  ///
  /// TODO(@getBoolean): Implementation
  final EpubGuide? guide;

  /// Deprecated in Epub 2.0.1
  ///
  /// A set of alternate reading sequences through the publication, such as selective views
  /// for various reading purposes, reader expertise levels, etc.
  ///
  /// TODO(@getBoolean): Implementation
  final EpubTours? tours;

  factory EpubPackage.fromData(Uint8List data) {
    return EpubPackageReader.fromData(data);
  }

  factory EpubPackage.fromArchiveFile(ArchiveFile archiveFile) {
    return EpubPackageReader.fromArchiveFile(archiveFile);
  }

  // GENERATED DO NOT MODOFY

  const EpubPackage({
    required this.packageIdentity,
    required this.publicationMetadata,
    required this.manifest,
    required this.spine,
    this.guide,
    this.tours,
  });

  EpubPackage copyWith({
    EpubPackageIdentity? packageIdentity,
    EpubPublicationMetadata? publicationMetadata,
    EpubManifest? manifest,
    EpubSpine? spine,
    EpubGuide? guide,
    EpubTours? tours,
  }) {
    return EpubPackage(
      packageIdentity: packageIdentity ?? this.packageIdentity,
      publicationMetadata: publicationMetadata ?? this.publicationMetadata,
      manifest: manifest ?? this.manifest,
      spine: spine ?? this.spine,
      guide: guide ?? this.guide,
      tours: tours ?? this.tours,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'packageIdentity': packageIdentity.toMap(),
      'publicationMetadata': publicationMetadata.toMap(),
      'manifest': manifest.toMap(),
      'spine': spine.toMap(),
      'guide': guide?.toMap(),
      'tours': tours?.toMap(),
    };
  }

  factory EpubPackage.fromMap(Map<String, dynamic> map) {
    return EpubPackage(
      packageIdentity: EpubPackageIdentity.fromMap(map['packageIdentity']),
      publicationMetadata:
          EpubPublicationMetadata.fromMap(map['publicationMetadata']),
      manifest: EpubManifest.fromMap(map['manifest']),
      spine: EpubSpine.fromMap(map['spine']),
      guide: map['guide'] != null ? EpubGuide.fromMap(map['guide']) : null,
      tours: map['tours'] != null ? EpubTours.fromMap(map['tours']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubPackage.fromJson(String source) =>
      EpubPackage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubPackage(packageIdentity: $packageIdentity, publicationMetadata: $publicationMetadata, manifest: $manifest, spine: $spine, guide: $guide, tours: $tours)';
  }

  @override
  List<Object> get props {
    return [
      packageIdentity,
      publicationMetadata,
      manifest,
      spine,
      guide ?? 'no guide',
      tours ?? 'no tours',
    ];
  }
}
