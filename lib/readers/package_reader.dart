import 'package:archive/archive.dart';

import '../epub_master.dart';

class PackageReader {
  static PackageFile parse(Archive archive) {
    return PackageFile(
      accessibilityFeatures: [],
      accessibilityHazards: [],
      accessibilitySummary: '',
      accessModes: [],
    );
  }
}
