library shu_epub.controllers;

import 'dart:convert' as convert;
import 'dart:typed_data';

import 'package:xml/xml.dart';

import '../models/models.dart';
import '../utils/collection_utils.dart';
import '../utils/xml_utils.dart';

part 'epub_package_controller.dart';
part 'epub_container_controller.dart';
part 'navigation/epub_navigation_controller.dart';
part 'navigation/epub_navigation_map_controller.dart';
part 'navigation/epub_navigation_list_controller.dart';
part 'navigation/epub_navigation_content_controller.dart';