



import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dotInfo04.dart';

class DrawingPainterOneLine extends CustomPainter{
  DrawingPainterOneLine({required this.lines, this.recentImage});
  final List<DotInfo04> lines;
  Uint8List? recentImage;

  // Future<ui.Image> loadUiImage(Uint8List imageBytes) async {
  //   // final ByteData data = await rootBundle.load(imageAssetPath);
  //   final Completer<ui.Image> completer = Completer();
  //   ui.decodeImageFromList(imageBytes, (ui.Image img) {
  //     return completer.complete(img);
  //   });
  //   return completer.future;
  // }

  Future<ui.Image> getUiImage(String imageAssetPath, int height, int width) async {
    final ByteData assetImageByteData = await rootBundle.load(imageAssetPath);
    final codec = await ui.instantiateImageCodec(
      assetImageByteData.buffer.asUint8List(),
      targetHeight: height,
      targetWidth: width,
    );
    return (await codec.getNextFrame()).image;
  }

  Future<void> drawImg(Canvas canvas)async{
    if(recentImage != null){
      ui.Image temp = await getUiImage("assets/images/temp.png", 100, 100);
      canvas.drawImage(temp, Offset(0, 0), Paint());
      // ui.Codec codec = await ui.instantiateImageCodec(recentImage!);
      // final frameInfo = await codec.getNextFrame();
      // canvas.drawImage(frameInfo.image, Offset(0.0, 0.0), Paint());
      // canvas.restore();
      // canvas.drawImageRect(frameInfo.image, Offset(0.0, 0.0), Paint());
    }
  }
  @override
  void paint(Canvas canvas, Size size) async{
    Offset? recentPoint;
    for(DotInfo04 oneDot in lines){
      if(recentPoint == null){
        recentPoint = oneDot.offset;
        continue;
      }
      ui.Paint p = Paint()
        ..color=oneDot.color
        ..strokeWidth=oneDot.size
        ..style=PaintingStyle.stroke
        ..maskFilter=MaskFilter.blur(BlurStyle.normal, oneDot.blur)
        ..strokeCap=StrokeCap.round;

      canvas.drawLine(
          recentPoint,
          oneDot.offset,
          p
      );
      recentPoint = oneDot.offset;
    }
    // canvas.transform();
    // canvas.save();
    // print(lines.length);
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // print(oldDelegate.toString());
    // TODO: implement shouldRepaint
    return true;
  }

}