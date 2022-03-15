class BookStructEnum {
  static const pageNumber = 'PAGE_NUMBER';
  static const note = 'NOTE';
  static const noteReference = 'NOTE_REFERENCE';
  static const annotation = 'ANNOTATION';
  static const lineNumber = 'LINE_NUMBER';
  static const optionalSidebar = 'OPTIONAL_SIDEBAR';
  static const optionalProducerNote = 'OPTIONAL_PROCUDER_NOTE';

  List<String> get values {
    return [
      pageNumber,
      note,
      noteReference,
      annotation,
      lineNumber,
      optionalSidebar,
      optionalProducerNote,
    ];
  }
}