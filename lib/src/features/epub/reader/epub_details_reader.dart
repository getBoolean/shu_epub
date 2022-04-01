part of shu_epub.features.epub.reader;

class EpubDetailsReader {
  const EpubDetailsReader();

  static EpubDetails fromData({
    required Uint8List data,
    required String bookId,
  }) {
    final controller = EpubArchiveController(
      data: data,
      bookId: bookId,
    );
    final archive = controller.archive;
    final isEpub = ArchiveService.isEpubFile(archive);
    if (!isEpub) {
      throw EpubException('File was not an EPUB');
    }

    // Parse container.xml
    final EpubContainer epubContainerFile =
        _handleContainerFileReadFails(archive);

    // Find the rootfile
    final String? rootfilePath = epubContainerFile.rootfile?.fullPath;
    ArchiveFile? archiveRootfile =
        archive.firstWhereOrNull((file) => file.name == rootfilePath);

    // Try to find the rootfile if above did not work
    if (archiveRootfile == null) {
      final String? rootfilePathFromArchive =
          ArchiveService.findRootfile(archive)?.fullPath;
      archiveRootfile = archive
          .firstWhereOrNull((file) => file.name == rootfilePathFromArchive);

      // Throw exception if neither methods worked
      if (archiveRootfile == null) {
        throw EpubException(
          'Epub Parsing Error: Could not find OPF file defined in container.xml',
        );
      }
    }

    // Parse the rootfile
    final EpubPackage packageFile =
        EpubPackage.fromData(archiveRootfile.content);

    final navigationId = packageFile.spine?.tocId;
    // TODO(@getBoolean): Create backup plan if navigation is not found
    if (navigationId == null || navigationId.isEmpty) {
      throw EpubException(
        'Epub Parsing Error: Could not find navigation id in the spine of container.xml',
      );
    }
    final navigationManifestItem = packageFile.manifest?.items.firstWhereOrNull(
      (element) => element.id == navigationId,
    );
    // TODO(@getBoolean): Create backup plan if navigation is not found
    if (navigationManifestItem == null) {
      throw EpubException(
        'Epub Parsing Error: Could not find the navigation manifest item in container.xml',
      );
    }
    final navigationRelativePath = navigationManifestItem.href;
    // TODO(@getBoolean): Create backup plan if navigation is not found
    if (navigationRelativePath == null) {
      throw EpubException(
        'Malformed Epub Manifest: Manifest Table of Contents item did not specify the href location of the navigation file.',
      );
    }

    final currentPathSplit = archiveRootfile.name.split(RegExp(r'/+'));
    currentPathSplit.removeLast();
    final currentPath = currentPathSplit.join('/');
    final navigationFullPath = currentPath + '/' + navigationRelativePath;

    final navigationFile = archive.findFile(navigationFullPath);
    // TODO(@getBoolean): Create backup plan if navigation is not found
    if (navigationFile == null) {
      throw EpubException(
        'Epub Parsing Error: Could not find the navigation file in archive at $navigationFullPath',
      );
    }
    final navigation = EpubNavigation.fromData(navigationFile.content);

    return EpubDetails(
      package: packageFile,
      container: epubContainerFile,
      navigation: navigation,
    );
  }

  static EpubContainer _handleContainerFileReadFails(Archive archive) {
    try {
      final EpubContainer epubContainerFile =
          EpubContainer.fromArchive(archive);
      return epubContainerFile;
    } on EpubException catch (_) {
      final epubRootfile = ArchiveService.findRootfile(archive);
      if (epubRootfile == null) {
        rethrow;
      }
      final EpubContainer epubContainerFile =
          EpubContainer(rootfileList: RootfileList(items: [epubRootfile]));
      return epubContainerFile;
    }
  }
}
