part of shu_epub.models;

class EpubGuide extends Equatable {
  final List<EpubGuideItem> items;

  const EpubGuide({
    this.items = const [],
  });

  EpubGuide copyWith({
    List<EpubGuideItem>? items,
  }) {
    return EpubGuide(
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((item) => item.toMap()),
    };
  }

  factory EpubGuide.zero() {
    return EpubGuide(items: []);
  }

  factory EpubGuide.fromMap(Map<String, dynamic> map) {
    return EpubGuide(
      items: List<EpubGuideItem>.from(
          map['items']?.map((x) => EpubGuideItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubGuide.fromJson(String source) =>
      EpubGuide.fromMap(json.decode(source));

  @override
  String toString() => 'EpubGuide(items: $items)';

  @override
  List<Object> get props => [items];
}
