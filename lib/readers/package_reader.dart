import 'package:archive/archive.dart';

import '../epub_master.dart';

class PackageReader {
  static PackageMetadata readMetadata(Archive archive) {
    return PackageMetadata(
      accessibilityFeatures: [],
      accessibilityHazards: [],
      accessibilitySummary: '',
      accessModes: [],
    );
  }
}
