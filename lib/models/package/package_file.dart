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
class EpubPackageFile extends Equatable {
  static const kPackageFileMimeType = 'application/oebps-package+xml';

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
  final PackageIdentity packageIdentity;

  // /// Publication metadata (title, author, publisher, etc.).
  // final EpubPublicationMetadata publicationMetadata;

  // /// A list of files (documents, images, style sheets, etc.) that make up the publication.
  // /// The manifest also includes fallback declarations for files of types not supported by
  // /// this specification.
  // final EpubManifest manifest;

  // /// An arrangement of documents providing a linear reading order.
  // final EpubSpine spine;

  // /// Deprecated in Epub 2.0.1
  // ///
  // /// A set of alternate reading sequences through the publication, such as selective views
  // /// for various reading purposes, reader expertise levels, etc.
  // final EpubTours? tours;

  // /// A set of references to fundamental structural features of the publication, such
  // /// as table of contents, foreword, bibliography, etc.
  // final EpubGuide guide;

  factory EpubPackageFile.fromData(Uint8List data) {
    return EpubPackageReader.fromData(data);
  }

  factory EpubPackageFile.fromArchiveFile(ArchiveFile archiveFile) {
    return EpubPackageReader.fromArchiveFile(archiveFile);
  }

  // GENERATED DO NOT MODOFY

  const EpubPackageFile({
    required this.packageIdentity,
  });

  EpubPackageFile copyWith({
    PackageIdentity? packageIdentity,
  }) {
    return EpubPackageFile(
      packageIdentity: packageIdentity ?? this.packageIdentity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'packageIdentity': packageIdentity.toMap(),
    };
  }

  factory EpubPackageFile.fromMap(Map<String, dynamic> map) {
    return EpubPackageFile(
      packageIdentity: PackageIdentity.fromMap(map['packageIdentity']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubPackageFile.fromJson(String source) =>
      EpubPackageFile.fromMap(json.decode(source));

  @override
  String toString() => 'EpubPackageFile(packageIdentity: $packageIdentity)';

  @override
  List<Object> get props => [packageIdentity];
}
