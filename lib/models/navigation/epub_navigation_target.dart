part of shu_epub.models;

class EpubNavigationTarget extends Equatable {
  /// Should have at least one item
  final List<EpubNavigationLabel> labels;
  final EpubNavigationContent content;
  EpubNavigationTarget({
    required this.labels,
    required this.content,
  });

  EpubNavigationTarget copyWith({
    List<EpubNavigationLabel>? labels,
    EpubNavigationContent? content,
  }) {
    return EpubNavigationTarget(
      labels: labels ?? this.labels,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'labels': labels.map((x) => x.toMap()).toList(),
      'content': content.toMap(),
    };
  }

  factory EpubNavigationTarget.fromMap(Map<String, dynamic> map) {
    return EpubNavigationTarget(
      labels: List<EpubNavigationLabel>.from(map['labels']?.map((x) => EpubNavigationLabel.fromMap(x)) ?? const []),
      content: EpubNavigationContent.fromMap(map['content']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationTarget.fromJson(String source) => EpubNavigationTarget.fromMap(json.decode(source));

  @override
  String toString() => 'EpubNavigationTarget(labels: $labels, content: $content)';

  @override
  List<Object> get props => [labels, content];
}
