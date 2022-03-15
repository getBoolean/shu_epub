part of shu_epub.models;

class EpubNavigationHead extends Equatable {
  final List<EpubNavigationHeadMeta> metadata;
  final List<EpubNavigationHeadSmilCustomTest> smilCustomTestList;

  const EpubNavigationHead({
    required this.metadata,
    required this.smilCustomTestList,
  });

  EpubNavigationHead copyWith({
    List<EpubNavigationHeadMeta>? metadata,
    List<EpubNavigationHeadSmilCustomTest>? smilCustomTestList,
  }) {
    return EpubNavigationHead(
      metadata: metadata ?? this.metadata,
      smilCustomTestList: smilCustomTestList ?? this.smilCustomTestList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'metadata': metadata.map((x) => x.toMap()).toList(),
      'smilCustomTestList': smilCustomTestList.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigationHead.fromMap(Map<String, dynamic> map) {
    return EpubNavigationHead(
      metadata: List<EpubNavigationHeadMeta>.from(map['metadata']?.map((x) => EpubNavigationHeadMeta.fromMap(x))),
      smilCustomTestList: List<EpubNavigationHeadSmilCustomTest>.from(map['smilCustomTestList']?.map((x) => EpubNavigationHeadSmilCustomTest.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationHead.fromJson(String source) =>
      EpubNavigationHead.fromMap(json.decode(source));

  @override
  String toString() => 'EpubNavigationHead(metadata: $metadata, smilCustomTestList: $smilCustomTestList)';

  @override
  List<Object> get props => [metadata, smilCustomTestList];
}
