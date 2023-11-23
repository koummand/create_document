// import 'package:universal_html/controller.dart';
// import 'package:universal_html/indexed_db.dart';
// import 'package:universal_html/js.dart';
// import 'package:universal_html/js_util.dart';
// import 'package:universal_html/parsing.dart';
// import 'package:universal_html/svg.dart';
// import 'package:universal_html/web_audio.dart';
// import 'package:universal_html/web_gl.dart';

import 'package:universal_html/html.dart';
import 'dart:convert';

Future<void> saveAndLauchFile(List<int> bytes, String fileName)async{
  AnchorElement(
    href: "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
    ..setAttribute("download", fileName)
    ..click();
}