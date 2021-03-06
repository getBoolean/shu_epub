library shu_epub.features.epub.controller;

import 'dart:async';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:archive/archive.dart' as a;
import 'package:archive/archive_io.dart' as aio;
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:xml/xml.dart';

import '../../exceptions.dart';
import '../../service.dart';
import '../../utils.dart';
import '../container/data.dart';
import '../epub.dart';
import '../navigation/data.dart';
import '../package/data.dart';

part 'controller/epub_archive_controller.dart';
part 'controller/epub_archive_io_controller.dart';
part 'controller/epub_controller_base.dart';
part 'controller/epub_details_reader_controller.dart';
part 'controller/epub_extracted_controller.dart';
