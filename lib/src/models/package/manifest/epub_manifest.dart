part of shu_epub.models;

class EpubManifest extends Equatable {
  final List<EpubManifestItem> items;

  const EpubManifest({
    required this.items,
  });

  EpubManifest copyWith({
    List<EpubManifestItem>? items,
  }) {
    return EpubManifest(
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((item) => item.toMap()),
    };
  }

  factory EpubManifest.zero() {
    return EpubManifest(items: []);
  }

  factory EpubManifest.fromMap(Map<String, dynamic> map) {
    return EpubManifest(
      items: List<EpubManifestItem>.from(
          map['items']?.map(EpubManifestItem.fromMap)),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubManifest.fromJson(String source) =>
      EpubManifest.fromMap(json.decode(source));

  @override
  String toString() => 'EpubManifest(items: $items)';

  @override
  List<Object> get props => [items];
}
