part of shu_epub.features.package.data;

/// http://idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.2
class EpubPublicationMetadata extends Equatable {
  static const elementName = 'metadata';

  /// Must not be an empty list
  final List<String> allTitles;

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
  /// specified, so it can be referenced from the [EpubPackageIdentity.uniqueIdentifier]
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

  String get title => allTitles.first;

  const EpubPublicationMetadata({
    required this.allTitles,
    this.creators = const [],
    this.subjects = const [],
    this.description,
    this.publisher,
    this.contributors = const [],
    this.extraMetadataItems = const [],
    this.metadataDate,
    this.type,
    this.format,
    required this.identifiers,
    this.source,
    required this.languages,
    this.relation,
    this.coverage,
    this.rights,
  });

  EpubPublicationMetadata copyWith({
    List<String>? allTitles,
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
      'allTitles': allTitles,
      'creators': creators.map((x) => x.toMap()).toList(),
      'subjects': subjects,
      'description': description,
      'publisher': publisher,
      'contributors': contributors.map((x) => x.toMap()).toList(),
      'extraMetadataItems': extraMetadataItems.map((x) => x.toMap()).toList(),
      'metadataDate': metadataDate,
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

  factory EpubPublicationMetadata.zero() {
    return EpubPublicationMetadata(
      allTitles: [],
      identifiers: [],
      languages: [],
    );
  }

  factory EpubPublicationMetadata.fromMap(Map<String, dynamic> map) {
    return EpubPublicationMetadata(
      allTitles: List<String>.from(map['allTitles']),
      creators: List<EpubMetadataContributer>.from(
          map['creators'].map(EpubMetadataContributer.fromMap)),
      subjects: List<String>.from(map['subjects']),
      description: map['description'],
      publisher: map['publisher'],
      contributors: List<EpubMetadataContributer>.from(
          map['contributors'].map(EpubMetadataContributer.fromMap)),
      extraMetadataItems: List<EpubExtraMetadata>.from(
          map['extraMetadataItems'].map(EpubExtraMetadata.fromMap)),
      metadataDate: map['metadataDate'],
      type: map['type'],
      format: map['format'],
      identifiers: List<EpubMetadataIdentifier>.from(
          map['identifiers'].map(EpubMetadataIdentifier.fromMap)),
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
      description ?? 'no description given',
      publisher ?? 'no publisher specified',
      contributors,
      extraMetadataItems,
      metadataDate ?? 'no date specified',
      type ?? 'no type specified',
      format ?? 'no format specified',
      identifiers,
      source ?? 'no source specified',
      languages,
      relation ?? 'no relation specified',
      coverage ?? 'no coverage specified',
      rights ?? 'no rights specified',
    ];
  }
}
