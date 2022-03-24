library shu_epub.features.epub;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:equatable/equatable.dart';

import '../exceptions.dart';
import '../features.dart';
import '../service.dart';
import '../utils.dart';

part 'epub/data/epub.dart';
part 'epub/reader/epub_reader.dart';
part 'epub/controller/epub_controller.dart';
part 'epub/controller/epub_archive_controller.dart';
