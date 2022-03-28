part of shu_epub.features.package.data;

class EpubTourSite extends EquatableXml {
  static const elementName = 'site';

  final String? title;

  /// Must refer to an OPS Content Document included in the manifest,
  /// and may include a fragment identifier as defined in section
  /// 4.1 of RFC 2396 (see http://www.ietf.org/rfc/rfc2396.txt).
  /// Each site element specifies a starting point from which the
  /// reader can explore freely. Reading Systems may use the bounds
  /// of the referenced element to determine the scope of the site.
  /// If a fragment identifier is not used, the scope is considered
  /// to be the entire document. This specification does not require
  /// Reading Systems to mark or otherwise identify the entire scope
  /// of a referenced element. The order of site elements is presumed
  /// to be significant, and should be used by Reading Systems to aid
  /// navigation.
  final String? href;

  /// Create an [EpubTourSite] object from the site XmlElement.
  ///
  /// Throws [EpubException] if the site element is not the root node
  factory EpubTourSite.fromXmlElement(XmlElement siteElement) {
    return EpubTourSiteReader.fromXmlElement(siteElement);
  }

  /// Create an instance of [EpubTourSite] from the [String] representation
  /// of the site element
  ///
  /// Throws [EpubException] if the string does not have the site element
  factory EpubTourSite.fromXmlString(String siteString) {
    return EpubTourSiteReader.fromXmlString(siteString);
  }

  /// Create an instance of [EpubTourSite] from the [Uint8List] data
  /// of the site element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the site element
  factory EpubTourSite.fromData(Uint8List siteData) {
    return EpubTourSiteReader.fromData(siteData);
  }

  const EpubTourSite({
    this.title,
    this.href,
  });

  EpubTourSite copyWith({
    String? title,
    String? href,
  }) {
    return EpubTourSite(
      title: title ?? this.title,
      href: href ?? this.href,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'href': href,
    };
  }

  factory EpubTourSite.fromMap(Map<String, dynamic> map) {
    return EpubTourSite(
      title: map['title'],
      href: map['href'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubTourSite.fromJson(String source) =>
      EpubTourSite.fromMap(json.decode(source));

  @override
  String toString() => 'EpubTourSite(title: $title, href: $href)';

  @override
  List<Object> get props => [title ?? 'no title', href ?? 'no href'];

  @override
  String toXmlString() {
    return '<site'
          '${title != null ? ' title="$title"' : ''}'
          '${href != null ? ' href="$href"': ''}'
          '/>';
  }
}
