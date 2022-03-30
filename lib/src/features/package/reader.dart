library shu_epub.features.package.reader;

import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:xml/xml.dart';

import '../../utils.dart';
import 'controller.dart';
import 'data.dart';

part 'reader/guide/epub_guide_item_reader.dart';
part 'reader/guide/epub_guide_reader.dart';
part 'reader/epub_package_reader.dart';
part 'reader/tours/epub_single_tour_reader.dart';
part 'reader/tours/epub_tour_site_reader.dart';
part 'reader/tours/epub_tours_reader.dart';
part 'reader/manifest/epub_manifest_reader.dart';
part 'reader/manifest/epub_manifest_item_reader.dart';
part 'reader/spine/epub_spine_item_ref_reader.dart';
part 'reader/spine/epub_spine_reader.dart';
part 'reader/publication_metadata/epub_publication_metadata_reader.dart';
part 'reader/publication_metadata/epub_metadata_title_reader.dart';
part 'reader/publication_metadata/epub_metadata_contributor_reader.dart';
part 'reader/publication_metadata/epub_metadata_creator_reader.dart';
part 'reader/publication_metadata/epub_metadata_identifier_reader.dart';
part 'reader/publication_metadata/epub_metadata_date_reader.dart';
