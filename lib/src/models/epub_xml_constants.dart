part of shu_epub.models;

class EpubXMLConstants {
  static const kAccessModeProperty = 'schema:accessMode';
  static const kAccessibilityFeatureProperty = 'schema:accessibilityFeature';
  static const kAccessibilitySummaryProperty = 'schema:accessibilitySummary';
  static const kAccessibilityHazardProperty = 'schema:accessibilityHazard';
  static const kAccessModeSufficientProperty = 'schema:accessModeSufficient';
  static const kAccessibilityAPIProperty = 'schema:accessibilityAPI';
  static const kAccessibilityControlProperty = 'schema:accessibilityControl';
  static const kContainerName = 'container';
  static const kContainerNamespace =
      'urn:oasis:names:tc:opendocument:xmlns:container';
  static const kPackageName = EpubPackage.elementName;
  static const kPackageNamespace = 'http://www.idpf.org/2007/opf';
  static const kMetadataName = 'metadata';
}
