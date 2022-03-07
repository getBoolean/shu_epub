part of shu_epub.models;

class EpubMetadataDate extends Equatable {
  /// Usually the date of publication, unless specified otherwise in [EpubMetadataDate.event]
  ///
  /// Represented in the form `YYYY[-MM[-DD]]`: a required 4-digit year, an optional 2-digit month, and if the month is given, an optional 2-digit day of month.
  final String date;
  
  /// The set of values for event are not defined by the EPUB specification; possible values may include: `creation`, `publication`, and `modification`.
  final String? event;

  const EpubMetadataDate({
    required this.date,
    this.event,
  });

  EpubMetadataDate copyWith({
    String? date,
    String? event,
  }) {
    return EpubMetadataDate(
      date: date ?? this.date,
      event: event ?? this.event,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'event': event,
    };
  }

  factory EpubMetadataDate.fromMap(Map<String, dynamic> map) {
    return EpubMetadataDate(
      date: map['date'] ?? '',
      event: map['event'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubMetadataDate.fromJson(String source) => EpubMetadataDate.fromMap(json.decode(source));

  @override
  String toString() => 'EpubMetadataDate(date: $date, event: $event)';

  @override
  List<Object> get props => [date, event ?? 'no event specified'];
}
