part of shu_epub.features.package.data;

/// http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2
class EpubPublicationMetadata extends Equatable {
  static const elementName = 'metadata';

  /// Must not be an empty list
  final List<EpubMetadataTitle> allTitles;

  /// A primary creator or author of the publication.
  ///
  /// The order of creator elements should be the order
  /// in which the creators' names are presented by
  /// the Reading System.
  final List<EpubMetadataContributer> creators;

  /// Contains a list of arbitrary phrases or keywords. There is no
  /// standardized list of subjects.
  final List<String> subjects;

  final String? description;

  final String? publisher;

  final List<EpubMetadataContributer> contributors;

  final List<EpubExtraMetadata> extraMetadataItems;

  /// Date of publication, in the format defined by
  /// ["Date and Time Formats"](http://www.w3.org/TR/NOTE-datetime)
  /// and by ISO 8601 on which it is based. In particular, dates
  /// without times are represented in the form `YYYY[-MM[-DD]]`: a
  /// required 4-digit year, an optional 2-digit month, and if the
  /// month is given, an optional 2-digit day of month.
  ///
  /// The date element has one optional OPF event attribute. The set
  /// of values for event are not defined by this specification;
  /// possible values may include: creation, publication, and modification.
  final EpubMetadataDate? metadataDate;

  /// Includes terms describing general categories, functions, genres,
  /// or aggregation levels for content.
  final String? type;

  /// The media type or dimensions of the resource. Best practice is
  /// to use a value from a controlled vocabulary (e.g. MIME media types),
  /// though not required.
  final String? format;

  /// An OPF Package Document must include at least one instance of
  /// [EpubMetadataIdentifier], however multiple instances are permitted.
  ///
  /// At least one [EpubMetadataIdentifier] must have [EpubMetadataIdentifier.id]
  /// specified, so it can be referenced from the [EpubPackage.uniqueIdentifier]
  /// attribute described in [Section 2.1](http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.1).
  ///
  /// Must not be an empty list
  final List<EpubMetadataIdentifier> identifiers;

  /// Information regarding a prior resource from which the publication was derived
  final String? source;

  /// Identifies a language of the intellectual content of the Publication.
  ///
  /// An OPF Package Document must include at least one instance of this element
  /// type, however multiple instances are permitted. The content of
  /// this element must comply with [RFC 3066](http://www.ietf.org/rfc/rfc3066.txt),
  /// or its successor on the IETF Standards Track.
  ///
  /// Must not be an empty list
  final List<String> languages;

  /// An identifier of an auxiliary resource and its relationship to the publication.
  final String? relation;

  /// The extent or scope of the publication's content
  final String? coverage;

  /// A statement about rights, or a reference to one.
  final String? rights;

  EpubMetadataTitle get title => allTitles.first;

  /// Create an [EpubPublicationMetadata] object from the metadata XmlElement.
  ///
  /// Throws [EpubException] if the metadata element is not the root node
  factory EpubPublicationMetadata.fromXmlElement(XmlElement metadataElement) {
    return EpubPublicationMetadataReader.fromXmlElement(metadataElement);
  }

  /// Create an instance of [EpubPublicationMetadata] from the [String] representation
  /// of the metadata element
  ///
  /// Throws [EpubException] if the string does not have the metadata element
  factory EpubPublicationMetadata.fromString(String metadataString) {
    return EpubPublicationMetadataReader.fromString(metadataString);
  }

  /// Create an instance of [EpubPublicationMetadata] from the [Uint8List] data
  /// of the metadata element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the metadata element
  factory EpubPublicationMetadata.fromData(Uint8List metadataData) {
    return EpubPublicationMetadataReader.fromData(metadataData);
  }

  const EpubPublicationMetadata({
    this.allTitles = const [],
    this.creators = const [],
    this.subjects = const [],
    this.description,
    this.publisher,
    this.contributors = const [],
    this.extraMetadataItems = const [],
    this.metadataDate,
    this.type,
    this.format,
    this.identifiers = const [],
    this.source,
    this.languages = const [],
    this.relation,
    this.coverage,
    this.rights,
  });

  EpubPublicationMetadata copyWith({
    List<EpubMetadataTitle>? allTitles,
    List<EpubMetadataContributer>? creators,
    List<String>? subjects,
    String? description,
    String? publisher,
    List<EpubMetadataContributer>? contributors,
    List<EpubExtraMetadata>? extraMetadataItems,
    EpubMetadataDate? metadataDate,
    String? type,
    String? format,
    List<EpubMetadataIdentifier>? identifiers,
    String? source,
    List<String>? languages,
    String? relation,
    String? coverage,
    String? rights,
  }) {
    return EpubPublicationMetadata(
      allTitles: allTitles ?? this.allTitles,
      creators: creators ?? this.creators,
      subjects: subjects ?? this.subjects,
      description: description ?? this.description,
      publisher: publisher ?? this.publisher,
      contributors: contributors ?? this.contributors,
      extraMetadataItems: extraMetadataItems ?? this.extraMetadataItems,
      metadataDate: metadataDate ?? this.metadataDate,
      type: type ?? this.type,
      format: format ?? this.format,
      identifiers: identifiers ?? this.identifiers,
      source: source ?? this.source,
      languages: languages ?? this.languages,
      relation: relation ?? this.relation,
      coverage: coverage ?? this.coverage,
      rights: rights ?? this.rights,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'allTitles': allTitles.map((x) => x.toMap()).toList(),
      'creators': creators.map((x) => x.toMap()).toList(),
      'subjects': subjects,
      'description': description,
      'publisher': publisher,
      'contributors': contributors.map((x) => x.toMap()).toList(),
      'extraMetadataItems': extraMetadataItems.map((x) => x.toMap()).toList(),
      'metadataDate': metadataDate?.toMap(),
      'type': type,
      'format': format,
      'identifiers': identifiers.map((x) => x.toMap()).toList(),
      'source': source,
      'languages': languages,
      'relation': relation,
      'coverage': coverage,
      'rights': rights,
    };
  }

  factory EpubPublicationMetadata.fromMap(Map<String, dynamic> map) {
    return EpubPublicationMetadata(
      allTitles: List<EpubMetadataTitle>.from(
          // ignore: unnecessary_lambdas
          map['allTitles']?.map((e) => EpubMetadataTitle.fromMap(e))),
      creators: List<EpubMetadataContributer>.from(
          // ignore: unnecessary_lambdas
          map['creators']?.map((e) => EpubMetadataContributer.fromMap(e))),
      subjects: List<String>.from(map['subjects']),
      description: map['description'],
      publisher: map['publisher'],
      contributors: List<EpubMetadataContributer>.from(
          // ignore: unnecessary_lambdas
          map['contributors']?.map((e) => EpubMetadataContributer.fromMap(e))),
      extraMetadataItems: List<EpubExtraMetadata>.from(
          // ignore: unnecessary_lambdas
          map['extraMetadataItems']?.map((e) => EpubExtraMetadata.fromMap(e))),
      metadataDate: map['metadataDate'] != null
          ? EpubMetadataDate.fromMap(map['metadataDate'])
          : null,
      type: map['type'],
      format: map['format'],
      identifiers: List<EpubMetadataIdentifier>.from(
          // ignore: unnecessary_lambdas
          map['identifiers']?.map((e) => EpubMetadataIdentifier.fromMap(e))),
      source: map['source'],
      languages: List<String>.from(map['languages']),
      relation: map['relation'],
      coverage: map['coverage'],
      rights: map['rights'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubPublicationMetadata.fromJson(String source) =>
      EpubPublicationMetadata.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubPublicationMetadata(allTitles: $allTitles, creators: $creators, subjects: $subjects, description: $description, publisher: $publisher, contributors: $contributors, extraMetadataItems: $extraMetadataItems, metadataDate: $metadataDate, type: $type, format: $format, identifiers: $identifiers, source: $source, languages: $languages, relation: $relation, coverage: $coverage, rights: $rights)';
  }

  @override
  List<Object> get props {
    return [
      allTitles,
      creators,
      subjects,
      description ?? 'no description',
      publisher ?? 'no publisher',
      contributors,
      extraMetadataItems,
      metadataDate ?? 'no metadataDate',
      type ?? 'no type',
      format ?? 'no format',
      identifiers,
      source ?? 'no source',
      languages,
      relation ?? 'no relation',
      coverage ?? 'no coverage',
      rights ?? 'no rights',
    ];
  }
}
