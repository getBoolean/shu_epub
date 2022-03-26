part of shu_epub.features.package.data;

class EpubMetadataDate extends Equatable {
  static const elementName = 'dc:date';

  /// Usually the date of publication, unless specified otherwise in [EpubMetadataDate.event]
  ///
  /// Represented in the form `YYYY[-MM[-DD]]`: a required 4-digit year, an optional 2-digit month, and if the month is given, an optional 2-digit day of month.
  final String value;

  /// The set of values for event are not defined by the EPUB specification; possible values may include: `creation`, `publication`, and `modification`.
  final String? event;

  /// Create an [EpubMetadataDate] object from the date XmlElement.
  ///
  /// Throws [EpubException] if the date element is not the root node
  factory EpubMetadataDate.fromXmlElement(XmlElement dateElement) {
    return EpubMetadataDateReader.fromXmlElement(dateElement);
  }

  /// Create an instance of [EpubMetadataDate] from the [String] representation
  /// of the date element
  ///
  /// Throws [EpubException] if the string does not have the date element
  factory EpubMetadataDate.fromString(String dateString) {
    return EpubMetadataDateReader.fromString(dateString);
  }

  /// Create an instance of [EpubMetadataDate] from the [Uint8List] data
  /// of the date element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the date element
  factory EpubMetadataDate.fromData(Uint8List dateData) {
    return EpubMetadataDateReader.fromData(dateData);
  }

  const EpubMetadataDate({
    this.value = '',
    this.event,
  });

  EpubMetadataDate copyWith({
    String? value,
    String? event,
  }) {
    return EpubMetadataDate(
      value: value ?? this.value,
      event: event ?? this.event,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'event': event,
    };
  }

  factory EpubMetadataDate.fromMap(Map<String, dynamic> map) {
    return EpubMetadataDate(
      value: map['value'] ?? '',
      event: map['event'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubMetadataDate.fromJson(String source) =>
      EpubMetadataDate.fromMap(json.decode(source));

  @override
  String toString() => 'EpubMetadataDate(value: $value, event: $event)';

  @override
  List<Object> get props => [value, event ?? 'no event'];
}
