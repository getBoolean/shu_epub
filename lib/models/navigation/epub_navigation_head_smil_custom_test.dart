part of shu_epub.models;

class EpubNavigationHeadSmilCustomTest extends Equatable {
  // id    ID    #REQUIRED
  // defaultState  (true|false)   'false'
  // override  (visible|hidden) 'hidden'
  // bookStruct  (PAGE_NUMBER|NOTE|NOTE_REFERENCE|ANNOTATION|LINE_NUMBER|OPTIONAL_SIDEBAR|OPTIONAL_PRODUCER_NOTE)  #IMPLIED
  final String id;
  final bool defaultState;
  final bool overrideHidden;
  final BookStruct bookStruct;
  
  const EpubNavigationHeadSmilCustomTest({
    required this.id,
    required this.defaultState,
    required this.overrideHidden,
    required this.bookStruct,
  });

  EpubNavigationHeadSmilCustomTest copyWith({
    String? id,
    bool? defaultState,
    bool? overrideHidden,
    BookStruct? bookStruct,
  }) {
    return EpubNavigationHeadSmilCustomTest(
      id: id ?? this.id,
      defaultState: defaultState ?? this.defaultState,
      overrideHidden: overrideHidden ?? this.overrideHidden,
      bookStruct: bookStruct ?? this.bookStruct,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'defaultState': defaultState,
      'overrideHidden': overrideHidden,
      'bookStruct': bookStruct.toMap(),
    };
  }

  factory EpubNavigationHeadSmilCustomTest.fromMap(Map<String, dynamic> map) {
    return EpubNavigationHeadSmilCustomTest(
      id: map['id'] ?? '',
      defaultState: map['defaultState'] ?? false,
      overrideHidden: map['overrideHidden'] ?? false,
      bookStruct: BookStruct.fromMap(map['bookStruct']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationHeadSmilCustomTest.fromJson(String source) =>
      EpubNavigationHeadSmilCustomTest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubNavigationHeadSmilCustomTest(id: $id, defaultState: $defaultState, overrideHidden: $overrideHidden, bookStruct: $bookStruct)';
  }

  @override
  List<Object> get props => [id, defaultState, overrideHidden, bookStruct];
}