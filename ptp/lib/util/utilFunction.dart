
// 인터넷에서 이미지 받아서 Uint8List 로 넘기기

import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:typed_data';


Future<Uint8List> getImageUint8ListFromUrl(String imageUrl) async{
  Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imageUrl))
      .load(imageUrl))
      .buffer
      .asUint8List();
  return bytes;
}