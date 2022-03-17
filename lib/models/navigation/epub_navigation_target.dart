part of shu_epub.models;

class EpubNavigationTarget extends Equatable {
  final EpubNavigationContent content;

  /// Should have at least one item
  final List<EpubNavigationLabel> navigationLabels;
  
  const EpubNavigationTarget({
    required this.content,
    required this.navigationLabels,
  });

  EpubNavigationTarget copyWith({
    EpubNavigationContent? content,
    List<EpubNavigationLabel>? navigationLabels,
  }) {
    return EpubNavigationTarget(
      content: content ?? this.content,
      navigationLabels: navigationLabels ?? this.navigationLabels,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content.toMap(),
      'navigationLabels': navigationLabels.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigationTarget.fromMap(Map<String, dynamic> map) {
    return EpubNavigationTarget(
      content: EpubNavigationContent.fromMap(map['content']),
      navigationLabels: List<EpubNavigationLabel>.from(map['navigationLabels']?.map((x) => EpubNavigationLabel.fromMap(x)) ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationTarget.fromJson(String source) => EpubNavigationTarget.fromMap(json.decode(source));

  @override
  String toString() => 'EpubNavigationTarget(content: $content, navigationLabels: $navigationLabels)';

  @override
  List<Object> get props => [content, navigationLabels];
}
