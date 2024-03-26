
// 인터넷에서 이미지 받아서 Uint8List 로 넘기기

import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';


Future<Uint8List> getImageUint8ListFromUrl(String imageUrl) async{
  Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imageUrl))
      .load(imageUrl))
      .buffer
      .asUint8List();
  return bytes;
}

Future<Uint8List?> getWidgetToUint8List({
  required BuildContext context,
  required GlobalKey globalKey,}) async {

  print("isNull : ${globalKey.currentWidget==null}");

  RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  // RenderCustomPaint boundary = globalKey.currentContext!.findRenderObject() as RenderCustomPaint;
  ui.Image image = await boundary.toImage();
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List pngBytes = byteData!.buffer.asUint8List();
  // print(pngBytes);
  //
  // var result = await showDialog(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       title: const Text("저장하시겠습니까?"),
  //       actions: [
  //         OutlinedButton(
  //             onPressed: (){
  //               Navigator.pop(context, pngBytes);
  //             },
  //             child: Text("저장")),
  //         OutlinedButton(
  //             onPressed: () => Navigator.pop(context, null),
  //             child: Text("취소")),
  //       ],
  //     )
  // );
  return pngBytes;
}