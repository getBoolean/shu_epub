library shu_epub.features.container.data;

import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:xml/xml.dart';

import '../../constants.dart';
import '../../shared.dart';
import '../../utils.dart';
import 'reader.dart';

part 'data/epub_container.dart';
part 'data/rootfile.dart';
part 'data/rootfile_list.dart';
