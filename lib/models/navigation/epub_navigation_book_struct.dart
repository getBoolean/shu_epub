part of shu_epub.models;

class BookStruct extends Equatable {
  final String pageNumber;
  final String note;
  final String noteReference;
  final String annotation;
  final String lineNumber;
  final String? sidebar;
  final String? producerNote;

  const BookStruct({
    required this.pageNumber,
    required this.note,
    required this.noteReference,
    required this.annotation,
    required this.lineNumber,
    this.sidebar,
    this.producerNote,
  });

  BookStruct copyWith({
    String? pageNumber,
    String? note,
    String? noteReference,
    String? annotation,
    String? lineNumber,
    String? sidebar,
    String? producerNote,
  }) {
    return BookStruct(
      pageNumber: pageNumber ?? this.pageNumber,
      note: note ?? this.note,
      noteReference: noteReference ?? this.noteReference,
      annotation: annotation ?? this.annotation,
      lineNumber: lineNumber ?? this.lineNumber,
      sidebar: sidebar ?? this.sidebar,
      producerNote: producerNote ?? this.producerNote,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pageNumber': pageNumber,
      'note': note,
      'noteReference': noteReference,
      'annotation': annotation,
      'lineNumber': lineNumber,
      'sidebar': sidebar,
      'producerNote': producerNote,
    };
  }

  factory BookStruct.fromMap(Map<String, dynamic> map) {
    return BookStruct(
      pageNumber: map['pageNumber'] ?? '',
      note: map['note'] ?? '',
      noteReference: map['noteReference'] ?? '',
      annotation: map['annotation'] ?? '',
      lineNumber: map['lineNumber'] ?? '',
      sidebar: map['sidebar'],
      producerNote: map['producerNote'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BookStruct.fromJson(String source) =>
      BookStruct.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookStruct(pageNumber: $pageNumber, note: $note, noteReference: $noteReference, annotation: $annotation, lineNumber: $lineNumber, sidebar: $sidebar, producerNote: $producerNote)';
  }

  @override
  List<Object> get props {
    return [
      pageNumber,
      note,
      noteReference,
      annotation,
      lineNumber,
      sidebar ?? 'no sidebar',
      producerNote ?? 'no sidebar',
    ];
  }
}
