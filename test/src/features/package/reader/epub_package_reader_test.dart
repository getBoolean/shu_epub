import 'dart:io' as io;

import 'package:archive/archive.dart';
import 'package:shu_epub/shu_epub.dart';
import 'package:shu_epub/src/service.dart';
import 'package:shu_epub/src/utils.dart';
import 'package:test/test.dart';

void main() {
  group('fromData', () {
    test(
      'parses rootfile, returns EpubPackageFile',
      () async {
        // arrange
        final xmlString = '''
<package xmlns="http://www.idpf.org/2007/opf" unique-identifier="isbn_9780545509800" version="2.0">
  <metadata xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:opf="http://www.idpf.org/2007/opf">
    <dc:title>The Rise of a Legend</dc:title>
    <dc:creator>Kathryn Lasky</dc:creator>
    <dc:contributor>Kathryn Lasky</dc:contributor>
    <dc:publisher>Scholastic Inc.</dc:publisher>
    <dc:format/>
    <dc:date>2013</dc:date>
    <dc:subject/>
    <dc:description>&lt;p&gt;An owlet hatches out onto Stormfast Island and into a world torn by war. For one hundred years, his people have fought off enemy owls from the Ice Talons, but the tide has turned. An invasion is coming, one the Kielian League won't have the strength to resist. Soon the tyrant owl Bylyric will rule over everything, and no honorable owl will be safe.&lt;p&gt;Only the small owl from Stormfast stands between Bylyric and total victory. Lyze is not very impressive to look at, but he has a wild idea for a snake and owl strike unit that just might give the soldiers of the Kielian League the edge they need.&lt;p&gt;This is his story, the story of an ordinary owl who rose to become Ezylryb of the Great Tree. This is the story of what it takes to make a Guardian of Ga'Hoole.&lt;p&gt;&lt;li&gt;"Lyze's story can be read easily as a stand-alone tale. . . . Both thoughtful and action-packed, this adventure illuminates the fantastical world that exists between dusk and dawn." &amp;#8212; KIRKUS REVIEWS, starred...</dc:description>
    <dc:rights>Copyright © 2013 by Kathryn Lasky</dc:rights>
    <dc:identifier id="isbn_9780545509800">978-0-545-50980-0</dc:identifier>
    <dc:language>en</dc:language>
    <meta content="" name="price"/>
    <meta content="cover-jpg" name="cover"/>
  </metadata>
  <manifest>
    <item href="css/9780545509800.css" id="style" media-type="text/css"/>
  </manifest>
  <spine toc="ncx">
    <itemref idref="cover"/>
  </spine>
  <guide>
    <reference href="cover.html" title="Cover Image" type="cover"/>
  </guide>
</package>
''';

        // act
        final EpubPackage packageFile =
            EpubPackageReader.fromXmlString(xmlString);

        // assert
        expect(packageFile.epubVersion, isNotNull);
        expect(packageFile.uniqueIdentifier, isNotNull);

        // contains at least one title
        expect(packageFile.publicationMetadata?.allTitles, isNotEmpty);

        // contains at least one language
        expect(packageFile.publicationMetadata?.languages, isNotEmpty);

        // contains at least one identifier
        expect(packageFile.publicationMetadata?.identifiers, isNotEmpty);

        // contains one primary identifier
        expect(
            packageFile.publicationMetadata?.identifiers
                .firstWhereOrNull((identifier) => identifier.isPrimary),
            isNotNull);

        // manifest should have at least one item
        expect(packageFile.manifest?.items, isNotEmpty);

        // spine should have at least one primary item
        expect(
          packageFile.spine?.getReadingOrder(),
          isNotEmpty,
          reason: 'spine should have at least one primary item',
        );
      },
    );
  });

  group('fromArchiveFile', () {
    test(
      'parses epub, returns EpubPackageFile',
      () async {
        // arrange
        final data = await io.File('test/assets/Guardians.epub').readAsBytes();
        final archive = ArchiveService.decodeZip(data);
        // Always works for this epub, may not be for others
        final ArchiveFile archiveFile = archive.files
            .firstWhereOrNull((file) => file.name.contains('.opf'))!;

        // act
        final EpubPackage packageFile =
            EpubPackageReader.fromArchiveFile(archiveFile);

        // assert
        expect(packageFile.epubVersion, isNotNull);
        expect(packageFile.uniqueIdentifier, isNotNull);

        // contains at least one title
        expect(packageFile.publicationMetadata?.allTitles, isNotEmpty);

        // contains at least one language
        expect(packageFile.publicationMetadata?.languages, isNotEmpty);

        // contains at least one identifier
        expect(packageFile.publicationMetadata?.identifiers, isNotEmpty);

        // contains one primary identifier
        expect(
            packageFile.publicationMetadata?.identifiers
                .firstWhereOrNull((identifier) => identifier.isPrimary),
            isNotNull);

        // manifest should have at least one item
        expect(packageFile.manifest?.items, isNotEmpty);

        // spine should have at least one primary item
        expect(
          packageFile.spine?.getReadingOrder(),
          isNotEmpty,
          reason: 'spine should have at least one primary item',
        );
      },
    );
  });
}
