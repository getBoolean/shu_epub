import 'package:archive/archive.dart';

import '../epub_master.dart';

class PackageReader {
  static PackageMetadata parse(Archive archive, ContainerFile containerFile) {
    return PackageMetadata(
      accessibilityFeatures: [],
      accessibilityHazards: [],
      accessibilitySummary: '',
      accessModes: [],
    );
  }
}
