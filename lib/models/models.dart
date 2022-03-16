library shu_epub.models;

import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:equatable/equatable.dart';

import '../enums/enums.dart';
import '../readers/readers.dart';
import '../utils/collection_utils.dart';

part 'container/epub_container_file.dart';
part 'container/root_file.dart';
part 'epub.dart';
part 'exception.dart';
part 'epub_media_types.dart';
part 'epub_xml_constants.dart';
part 'package/epub_package_file.dart';
part 'package/package_identity/epub_package_identity.dart';
part 'package/publication_metadata/epub_package_accessibility_metadata.dart';
part 'package/publication_metadata/epub_extra_metadata.dart';
part 'package/publication_metadata/epub_metadata_contributer.dart';
part 'package/publication_metadata/epub_metadata_identifier.dart';
part 'package/publication_metadata/epub_metadata_date.dart';
part 'package/guide/epub_guide_reference.dart';
part 'package/guide/epub_guide.dart';
part 'package/manifest/epub_manifest.dart';
part 'package/manifest/epub_manifest_item.dart';
part 'package/publication_metadata/epub_publication_metadata.dart';
part 'package/spine/epub_spine.dart';
part 'package/spine/epub_spine_item_ref.dart';
part 'package/tours/epub_single_tour.dart';
part 'package/tours/epub_tour_site.dart';
part 'package/tours/epub_tours.dart';
part 'navigation/epub_navigation.dart';
part 'navigation/epub_navigation_head.dart';
part 'navigation/epub_navigation_head_meta.dart';
part 'navigation/epub_navigation_document_author.dart';
part 'navigation/epub_navigation_document_title.dart';
part 'navigation/epub_navigation_document_image.dart';
part 'navigation/epub_navigation_map.dart';
part 'navigation/epub_navigation_info.dart';
part 'navigation/epub_navigation_point.dart';
part 'navigation/epub_navigation_label.dart';
part 'navigation/epub_navigation_content.dart';
part 'navigation/epub_navigation_page_list.dart';
part 'navigation/epub_navigation_target.dart';