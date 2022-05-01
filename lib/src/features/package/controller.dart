library shu_epub.features.package.controller;

import 'dart:convert';
import 'dart:typed_data';

import 'package:xml/xml.dart';

import '../../constants.dart';
import '../../exceptions.dart';
import '../../shared.dart';
import '../../utils.dart';
import 'data.dart';

part 'controller/guide/epub_guide_reader_controller.dart';
part 'controller/guide/epub_guide_item_reader_controller.dart';
part 'controller/epub_package_reader_controller.dart';
part 'controller/tours/epub_single_tour_reader_controller.dart';
part 'controller/tours/epub_tour_site_reader_controller.dart';
part 'controller/tours/epub_tours_reader_controller.dart';
part 'controller/manifest/epub_manifest_reader_controller.dart';
part 'controller/manifest/epub_manifest_item_reader_controller.dart';
part 'controller/spine/epub_spine_reader_controller.dart';
part 'controller/spine/epub_spine_item_ref_reader_controller.dart';
part 'controller/publication_metadata/epub_publication_metadata_reader_controller.dart';
part 'controller/publication_metadata/epub_metadata_title_reader_controller.dart';
part 'controller/publication_metadata/epub_metadata_contributor_reader_controller.dart';
part 'controller/publication_metadata/epub_metadata_creator_reader_controller.dart';
part 'controller/publication_metadata/epub_metadata_identifier_reader_controller.dart';
part 'controller/publication_metadata/epub_metadata_date_reader_controller.dart';
