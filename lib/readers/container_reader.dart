import 'dart:convert' as convert;
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:xml/xml.dart';
import '../epub_master.dart';
import '../utils/collection_utils.dart';

class ContainerReader {
  static ContainerFile parse(Archive archive) {
    // Find `META-INF/container.xml` file.
    final ArchiveFile? containerFile = archive.files
        .firstWhereOrNull((element) => element.name == ContainerFile.filepath);
    if (containerFile == null) {
      throw EpubException(
          'Epub Parsing Exception: Could not find "${ContainerFile.filepath}"');
    }

    final containerElement = _getContainerElement(containerFile);
    if (containerElement == null) {
      throw EpubException(
        'Epub Parsing Exception: Could not find <${EpubConstants.kContainerName}> element in "${ContainerFile.filepath}"',
      );
    }

    final version = _getVersion(containerElement);

    if (version == null) {
      throw EpubException(
        'Epub Parsing Exception: Could not find version attribute for container element in "${ContainerFile.filepath}"',
      );
    }

    if (version != '1.0') {
      throw EpubException(
        'Epub Parsing Exception: OCF Container version $version not supported from file "${ContainerFile.filepath}"',
      );
    }

    final List<RootFile> rootfileList = _readRootfiles(containerElement);

    if (!containsOPSPackageElement(rootfileList)) {
      throw EpubException(
        'Epub Parsing Exception: EPUB container at path "${ContainerFile.filepath}" does not contain an element with media-type attribute value of "${EpubConstants.kOPFMimeType}"',
      );
    }

    return ContainerFile(
      rootfileList: rootfileList,
      version: version,
    );
  }

  static bool containsOPSPackageElement(List<RootFile> rootfileList) {
    return rootfileList
        .where(
          (element) => element.mediaType == EpubConstants.kOPFMimeType,
        )
        .isNotEmpty;
  }

  static String? _getVersion(XmlElement containerElement) {
    return containerElement.getAttribute('version');
  }

  static List<RootFile> _readRootfiles(XmlElement containerElement) {
    final rootfilesElement =
        containerElement.findElements('rootfiles').firstOrNull;
    if (rootfilesElement == null) {
      throw EpubException(
        'Epub Parsing Exception: EPUB container at path "${ContainerFile.filepath}" did not have a <rootfiles> element',
      );
    }
    final rootfilesXml = rootfilesElement.findElements('rootfile').toList();
    if (rootfilesXml.isEmpty) {
      throw EpubException(
        'Epub Parsing Exception: EPUB container at path "${ContainerFile.filepath}" did not have any <rootfile> elements',
      );
    }

    final rootfiles = _rootfilesXmlToRootFileList(rootfilesXml);

    return rootfiles;
  }

  /// Parse the rootfiles XML and return the filepath and media type for each
  static List<RootFile> _rootfilesXmlToRootFileList(
    List<XmlNode> rootfilesXml,
  ) {
    return rootfilesXml.map((childElement) {
      final fullPath = childElement.getAttribute('full-path');
      if (fullPath == null) {
        throw EpubException(
          'Epub Parsing Exception: EPUB container at path "${ContainerFile.filepath}" rootfile element did not have a "full-path" attribute',
        );
      }
      final mediaType = childElement.getAttribute('media-type');
      if (mediaType == null) {
        throw EpubException(
          'Epub Parsing Exception: EPUB container at path "${ContainerFile.filepath}" rootfile element did not have a "media-type" attribute',
        );
      }
      return RootFile(fullPath: fullPath, mediaType: mediaType);
    }).toList();
  }

  static XmlElement? _getContainerElement(ArchiveFile containerFile) {
    try {
      final Uint8List containerFileContent = containerFile.content;
      final xmlString = convert.utf8.decode(containerFileContent);
      final document = XmlDocument.parse(xmlString);
      // Find container element which MUST have namespace `urn:oasis:names:tc:opendocument:xmlns:container`
      final container = document
          .findAllElements(
            EpubConstants.kContainerName,
            namespace: EpubConstants.kContainerNamespace,
          )
          .firstOrNull;
      return container;
    } on Exception catch (e, st) {
      throw EpubException(
          'Epub Parsing Exception: Could not read container.xml', e, st);
    }
  }
}
