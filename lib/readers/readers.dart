library epub_master.readers;

import 'dart:convert' as convert;
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:xml/xml.dart';

import '../epub_master.dart';
import '../service/service.dart';
import '../utils/collection_utils.dart';
import '../utils/file_utils.dart';

part 'container_reader.dart';
part 'epub_reader.dart';
part 'package_reader.dart';
