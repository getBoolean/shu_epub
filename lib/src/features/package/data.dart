library shu_epub.features.package.data;

import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

import '../../enums.dart';
import '../../shared.dart';
import 'reader.dart';

part 'data/publication_metadata/epub_extra_metadata.dart';
part 'data/publication_metadata/epub_metadata_creator.dart';
part 'data/publication_metadata/epub_metadata_contributor.dart';
part 'data/publication_metadata/epub_metadata_identifier.dart';
part 'data/publication_metadata/epub_metadata_date.dart';
part 'data/guide/epub_guide_item.dart';
part 'data/guide/epub_guide.dart';
part 'data/manifest/epub_manifest.dart';
part 'data/manifest/epub_manifest_item.dart';
part 'data/publication_metadata/epub_publication_metadata.dart';
part 'data/publication_metadata/epub_metadata_title.dart';
part 'data/spine/epub_spine.dart';
part 'data/spine/epub_spine_item_ref.dart';
part 'data/tours/epub_single_tour.dart';
part 'data/tours/epub_tour_site.dart';
part 'data/tours/epub_tours.dart';
part 'data/epub_package.dart';
