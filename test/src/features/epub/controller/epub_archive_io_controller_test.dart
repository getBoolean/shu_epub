import 'package:shu_epub/shu_epub.dart';
import 'package:test/test.dart';

void main() {
  late EpubArchiveIOController sut;

  setUpAll(() async {
    sut = EpubArchiveIOController('test/assets/Guardians.epub',
        enableCache: false);
  });

  tearDownAll(() {
    sut.clear();
  });

  group('getDetails', () {
    test(
      'on a valid epub archive',
      () async {
        final expected = EpubDetails(
          container: EpubContainer(
              containerVersion: '1.0',
              rootfileList: RootfileList(items: [
                Rootfile(
                  fullPath: 'OEBPS/package.opf',
                  mediaType: 'application/oebps-package+xml',
                ),
              ])),
          package: EpubPackage(
            epubVersion: '2.0',
            uniqueIdentifier: 'isbn_9780545509800',
            publicationMetadata: EpubPublicationMetadata(
                allTitles: [EpubMetadataTitle(text: 'The Rise of a Legend')],
                creators: [EpubMetadataCreator(name: 'Kathryn Lasky')],
                contributors: [EpubMetadataContributor(name: 'Kathryn Lasky')],
                publisher: 'Scholastic Inc.',
                description:
                    '''<p>An owlet hatches out onto Stormfast Island and into a world torn by war. For one hundred years, his people have fought off enemy owls from the Ice Talons, but the tide has turned. An invasion is coming, one the Kielian League won't have the strength to resist. Soon the tyrant owl Bylyric will rule over everything, and no honorable owl will be safe.<p>Only the small owl from Stormfast stands between Bylyric and total victory. Lyze is not very impressive to look at, but he has a wild idea for a snake and owl strike unit that just might give the soldiers of the Kielian League the edge they need.<p>This is his story, the story of an ordinary owl who rose to become Ezylryb of the Great Tree. This is the story of what it takes to make a Guardian of Ga'Hoole.<p><li>"Lyze's story can be read easily as a stand-alone tale. . . . Both thoughtful and action-packed, this adventure illuminates the fantastical world that exists between dusk and dawn." &#8212; KIRKUS REVIEWS, starred...''',
                metadataDate: EpubMetadataDate(value: '2013'),
                rights: 'Copyright © 2013 by Kathryn Lasky',
                identifiers: [
                  EpubMetadataIdentifier(
                      id: 'isbn_9780545509800', value: '978-0-545-50980-0')
                ],
                languages: ['en'],
                extraMetadataItems: [
                  EpubExtraMetadata(name: 'price', content: ''),
                  EpubExtraMetadata(name: 'cover', content: 'cover-jpg'),
                ]),
            manifest: EpubManifest(items: [
              EpubManifestItem(
                href: 'css/9780545509800.css',
                id: 'style',
                mediaType: 'text/css',
              ),
              EpubManifestItem(
                href: 'toc.ncx',
                id: 'ncx',
                mediaType: 'application/x-dtbncx+xml',
              ),
              // TODO...
            ]),
            spine: EpubSpine(tocId: 'ncx', itemRefs: [
              EpubSpineItemRef(idref: 'cover'),
              EpubSpineItemRef(idref: 'title'),
              EpubSpineItemRef(idref: 'ded001'),
              EpubSpineItemRef(idref: 'toc01'),
              EpubSpineItemRef(idref: 'fm001'),
              // TODO...
            ]),
            guide: EpubGuide(items: [
              EpubGuideItem(
                  href: 'cover.html', title: 'Cover Image', type: 'cover'),
              EpubGuideItem(
                  href: 'e9780545509800_copy001.html',
                  title: 'Copyright',
                  type: 'copyright-page'),
              EpubGuideItem(
                  href: 'e9780545509800_toc001.html',
                  title: 'Table of Contents',
                  type: 'toc'),
            ]),
          ),
          navigation: EpubNavigation(),
        );
        final actual = await sut.getEpubDetails();
        // print(actual?.package?.publicationMetadata);
        // print(expected.package?.publicationMetadata);

        expect(actual, isNotNull);
        expect(actual?.container, expected.container);
        expect(actual?.package?.epubVersion, expected.package?.epubVersion);
        expect(actual?.package?.uniqueIdentifier,
            expected.package?.uniqueIdentifier);
        expect(actual?.package?.publicationMetadata,
            expected.package?.publicationMetadata);
        expect(actual?.package?.spine?.itemRefs.first,
            expected.package?.spine?.itemRefs.first);
        expect(actual?.package?.spine?.tocId, expected.package?.spine?.tocId);
        expect(actual?.package?.guide?.items.first,
            expected.package?.guide?.items.first);
        expect(actual?.package?.guide, expected.package?.guide);
      },
    );
  });
}
