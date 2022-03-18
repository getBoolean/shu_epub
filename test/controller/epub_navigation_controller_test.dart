import 'dart:io' as io;

import 'package:shu_epub/controllers/controllers.dart';
import 'package:shu_epub/utils/collection_utils.dart';
import 'package:test/test.dart';

void main() {
  late EpubNavigationController sut;

  setUp(() async {
    final data =
        await io.File('test/assets/Guardians/OEBPS/toc.ncx').readAsBytes();
    sut = EpubNavigationController(data);
  });

  group('getVersion', () {
    test(
      'on request, expect "2005-1"',
      () async {
        final expectedValue = '2005-1';
        final version = sut.getVersion();

        expect(
          version,
          expectedValue,
          reason: 'Version should be a supported value',
        );
      },
    );

    test(
      'on request, expect a non empty String',
      () async {
        final version = sut.getVersion();

        expect(
          version,
          isNotEmpty,
          reason: 'Version should not be an empty String',
        );
      },
    );
  });

  group('getLanguage', () {
    test(
      'on request, expect a non empty String',
      () async {
        final language = sut.getLanguage();

        expect(
          language ?? '\$none',
          isNotEmpty,
          reason: 'Language should not be an empty string',
        );
      },
    );
  });

  group('getHead', () {
    test(
      'on request, expect non empty meta list',
      () async {
        final head = sut.getHead();

        expect(
          head.metadata,
          isNotEmpty,
          reason: 'Head should have at least one element',
        );
      },
    );
  });

  group('getDocTitle', () {
    test(
      'on request, expect titles list not empty',
      () async {
        final docTitle = sut.getDocTitle();

        expect(
          docTitle.titles,
          isNotEmpty,
          reason: 'Document title should be provided',
        );
      },
    );
  });

  group('getDocAuthors', () {
    test(
      'returns the author',
      () async {
        final docAuthors = sut.getDocAuthors();

        expect(
          docAuthors,
          isNotEmpty,
          reason: 'This book provides the author',
        );

        expect(
          docAuthors.firstOrNull?.authors ?? [],
          isNotEmpty,
          reason: 'This book provides the author and should include it as text',
        );
      },
    );

    test(
      'returns the author with text',
      () async {
        final docAuthors = sut.getDocAuthors();

        expect(
          docAuthors.firstOrNull?.authors ?? [],
          isNotEmpty,
          reason: 'This book provides the author and should include it as text',
        );
      },
    );
  });

  group('getNavigationMap', () {
    test(
      'Returns with navigation points',
      () async {
        final navigationMap = sut.getNavigationMap();
        expect(navigationMap.navigationPoints, isNotEmpty);
      },
    );

    test(
      'Returns with navigation no info list',
      () async {
        final navigationMap = sut.getNavigationMap();
        expect(navigationMap.navigationInfoList, isNull);
      },
    );

    test(
      'Returns with navigation no labels',
      () async {
        final navigationMap = sut.getNavigationMap();
        expect(navigationMap.navigationLabels, isNull);
      },
    );

    test(
      'Returns navigation point\'s first item with labels',
      () async {
        final navigationMap = sut.getNavigationMap();

        expect(navigationMap.navigationPoints.first.labels, isNotEmpty);
      },
    );

    test(
      'Returns navigation point\'s first item with id',
      () async {
        final navigationMap = sut.getNavigationMap();

        expect(navigationMap.navigationPoints.first.id, isNotEmpty);
      },
    );

    test(
      'Returns navigation point\'s first item with playOrder as a number',
      () async {
        final navigationMap = sut.getNavigationMap();

        expect(navigationMap.navigationPoints.first.playOrder, isNotNull);
        expect(navigationMap.navigationPoints.first.playOrder, isNotNaN);
      },
    );
  });

  group('getPageList', () {
    test(
      'is null',
      () async {
        final pageList = sut.getPageList();
        expect(pageList, isNull);
      },
    );
  });

  group('getNavigationLists', () {
    test(
      'is empty',
      () async {
        final navLists = sut.getNavigationLists();
        expect(navLists, isEmpty);
      },
    );
  });
}
