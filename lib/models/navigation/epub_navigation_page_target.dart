part of shu_epub.models;

class EpubNavigationPageTarget extends Equatable {
  /// Should have at least one item
  final List<EpubNavigationLabel> labels;
  final EpubNavigationContent content;

  const EpubNavigationPageTarget({
    required this.labels,
    required this.content,
  });

  EpubNavigationPageTarget copyWith({
    List<EpubNavigationLabel>? labels,
    EpubNavigationContent? content,
  }) {
    return EpubNavigationPageTarget(
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

  factory EpubNavigationPageTarget.fromMap(Map<String, dynamic> map) {
    return EpubNavigationPageTarget(
      labels: List<EpubNavigationLabel>.from(map['labels']?.map((x) => EpubNavigationLabel.fromMap(x)) ?? const []),
      content: EpubNavigationContent.fromMap(map['content']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationPageTarget.fromJson(String source) => EpubNavigationPageTarget.fromMap(json.decode(source));

  @override
  String toString() => 'EpubNavigationTarget(labels: $labels, content: $content)';

  @override
  List<Object> get props => [labels, content];
}
