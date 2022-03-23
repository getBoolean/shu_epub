library shu_epub.readers;

import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:xml/xml.dart';

import '../controllers/controllers.dart';
import '../models/models.dart';
import '../service/service.dart';
import '../utils/collection_utils.dart';

part 'epub_container_reader.dart';
part 'epub_reader.dart';
part 'epub_package_reader.dart';
part 'navigation/epub_navigation_reader.dart';
part 'navigation/epub_navigation_map_reader.dart';
part 'navigation/epub_navigation_list_reader.dart';
part 'navigation/epub_navigation_content_reader.dart';
part 'navigation/epub_navigation_document_author_reader.dart';
part 'navigation/epub_navigation_document_title_reader.dart';
part 'navigation/epub_navigation_head_reader.dart';
