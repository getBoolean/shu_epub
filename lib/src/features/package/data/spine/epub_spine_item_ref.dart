part of shu_epub.features.package.data;

class EpubSpineItemRef extends Equatable {
  final String idref;

  /// If false, it may be viewed separately from the main flow
  /// of the order defined by the [EpubManifest]
  ///
  /// Designates whether the associated OPS Content Document is
  /// primary (`linear`=`true`, which is the default when linear
  /// is not present) or auxiliary (`linear`=`false`.)
  final bool linear;

  bool get isPrimary => linear;
  bool get isAuxiliary => !linear;

  const EpubSpineItemRef({
    required this.idref,
    this.linear = true,
  });

  EpubSpineItemRef copyWith({
    String? idref,
    bool? linear,
  }) {
    return EpubSpineItemRef(
      idref: idref ?? this.idref,
      linear: linear ?? this.linear,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idref': idref,
      'linear': linear,
    };
  }

  factory EpubSpineItemRef.fromMap(Map<String, dynamic> map) {
    return EpubSpineItemRef(
      idref: map['idref'] ?? '',
      linear: map['linear'] ?? true,
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubSpineItemRef.fromJson(String source) =>
      EpubSpineItemRef.fromMap(json.decode(source));

  @override
  String toString() => 'EpubSpineItemRef(idref: $idref, linear: $linear)';

  @override
  List<Object> get props => [idref, linear];
}
