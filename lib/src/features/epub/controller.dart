library shu_epub.features.epub.controller;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:meta/meta.dart';
import 'package:xml/xml.dart';
import '../../exceptions.dart';
import '../../service.dart';
import '../../utils.dart';
import '../container/data.dart';
import '../epub.dart';
import '../navigation/data.dart';
import '../package/data.dart';

part 'controller/epub_archive_controller.dart';
part 'controller/epub_controller.dart';
part 'controller/epub_details_controller.dart';
