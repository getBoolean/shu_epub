library shu_epub.models;

import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:equatable/equatable.dart';

import '../enums/enums.dart';
import '../readers/readers.dart';

part 'container/epub_container_file.dart';
part 'container/root_file.dart';
part 'epub.dart';
part 'exception.dart';
part 'epub_media_types.dart';
part 'epub_xml_constants.dart';
part 'package/epub_package_file.dart';
part 'package/epub_package_identity.dart';
part 'package/package_metadata.dart';
