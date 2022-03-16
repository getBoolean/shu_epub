part of shu_epub.models;

/// Contains description(s) of target, as well as a pointer to entire content
/// of target. Hierarchy is represented by nesting navPoints.  "class" attribute
/// describes the kind of structural unit this object represents (e.g.,
/// "chapter", "section").
class EpubNavigationPoint extends Equatable {
  final String id;
  final String? classType;
  final String? playOrder;

  const EpubNavigationPoint({
    required this.id,
    this.classType,
    this.playOrder,
  });

  EpubNavigationPoint copyWith({
    String? id,
    String? classType,
    String? playOrder,
  }) {
    return EpubNavigationPoint(
      id: id ?? this.id,
      classType: classType ?? this.classType,
      playOrder: playOrder ?? this.playOrder,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'classType': classType,
      'playOrder': playOrder,
    };
  }

  factory EpubNavigationPoint.fromMap(Map<String, dynamic> map) {
    return EpubNavigationPoint(
      id: map['id'] ?? '',
      classType: map['classType'],
      playOrder: map['playOrder'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationPoint.fromJson(String source) =>
      EpubNavigationPoint.fromMap(json.decode(source));

  @override
  String toString() =>
      'EpubNavigationPoint(id: $id, classType: $classType, playOrder: $playOrder)';

  @override
  List<Object> get props {
    return [
      id,
      classType ?? 'no classification specified',
      playOrder ?? 'no play order specified',
    ];
  }
}
