import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:xml/xml.dart';

import '../epub_master.dart';
import '../utils/collection_utils.dart';
import '../utils/file_utils.dart';

class PackageReader {
  static PackageFile parse(Archive archive, ContainerFile packageFile) {
    final rootfilePath = packageFile.rootfile.fullPath;
    final ArchiveFile? file = archive.findFile(rootfilePath);
    if (file == null) {
      throw EpubException('Epub Parsing Error: Could not find OPF file');
    }

    final XmlElement? packageElement = _getPackageElement(file);
    if (packageElement == null) {
      throw EpubException(
        'Epub Parsing Exception: Could not find <${EpubConstants.kPackageName}> element in "$rootfilePath"',
      );
    }

    final PackageIdentity packageIdentity = _handleParsePackageIdentity(packageElement, rootfilePath);

    return PackageFile(
      packageIdentity: packageIdentity,
    );
  }

  static PackageIdentity _handleParsePackageIdentity(XmlElement packageElement, String rootfilePath) {
    final version = _getVersion(packageElement);
    if (version == null) {
      throw EpubException(
        'Epub Parsing Exception: Could not find version attribute in "$rootfilePath"',
      );
    }
    final uniqueIdentifier = _getUniqueIdentifier(packageElement);
    if (uniqueIdentifier == null) {
      throw EpubException(
        'Epub Parsing Exception: Could not find unique-identifier attribute in "$rootfilePath"',
      );
    }
    
    final packageIdentity = PackageIdentity(
      uniqueIdentifier: uniqueIdentifier,
      version: version,
    );
    return packageIdentity;
  }

  static String? _getVersion(XmlElement packageElement) {
    return packageElement.getAttribute('version');
  }

  static String? _getUniqueIdentifier(XmlElement packageElement) {
    return packageElement.getAttribute('unique-identifier');
  }

  static XmlElement? _getPackageElement(ArchiveFile packageFile) {
    try {
      final containerFileContent = packageFile.content;

      final bool isU8 = packageFile.content is Uint8List;
      final bool isU16 = packageFile.content is Uint16List;
      final String xmlString;
      if (isU8) {
        xmlString = FileUtils.convertUtf8ToString(containerFileContent);
      } else if (isU16) {
        xmlString = FileUtils.convertUtf16ToString(containerFileContent);
      } else {
        throw EpubException(
          'Epub Parsing Error: ${packageFile.name} was not encoded in UTF-8 or UTF-16. Only UTF-8 or UTF-16 is supported.',
        );
      }
      final packageFileStr = XmlDocument.parse(xmlString);
      // Find container element which MUST have namespace `http://www.idpf.org/2007/opf`
      final package = packageFileStr
          .findAllElements(
            EpubConstants.kPackageName,
            namespace: EpubConstants.kPackageNamespace,
          )
          .firstOrNull;
      return package;
    } on Exception catch (e, st) {
      throw EpubException(
        'Epub Parsing Exception: Could not read ${packageFile.name}',
        e,
        st,
      );
    }
  }
}
