
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ptp/08_drawing02/DotInfo.dart';

class DrawingPainter extends CustomPainter{
  DrawingPainter({required List<List<DotInfo>> lines, this.recentImage}):lines=lines;
  final List<List<DotInfo>> lines;
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

    // canvas.drawImage(image, offset, paint)
    // canvas.save();
    // try
    // try{
    //   canvas.restore();
    // }on Exception catch(e){
    //   print(e);
    // }
    // canvas.restore();
    // drawImg(canvas);

    for(var oneLine in lines){
      // Color? color;
      // double? blur;
      // var l = <Offset>[];
      // var p = Path();
      // for(DotInfo oneDot in oneLine){
      //   color ??= oneDot.color;
      //   size = oneDot.size;
      //   blur ??= oneDot.blur;
      //   l.add(oneDot.offset);
      // }
      // p.addPolygon(l, false);
      // canvas.drawPath(
      //     p,
      //     Paint()
      //       ..color = color!
      //       ..strokeWidth=size!
      //       ..maskFilter=MaskFilter.blur(BlurStyle.normal, blur!)
      //       ..strokeCap=StrokeCap.round
      //       ..style=PaintingStyle.stroke
      //       // ..blendMode=BlendMode.dstOut
      //       ..blendMode=BlendMode.darken
      // );
      Offset? recentPoint;
      for(DotInfo oneDot in oneLine){
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

      // final picture = recorder.endRecording();
      // final img = await picture.toImage(size.width.round(), size.height.round());
      // canvas2.drawImage(img, Offset(0, 0), Paint());

      // canvas.drawPoints(
      //     PointMode.lines,
      //     l,
      //     Paint()
      //       // ..color = color!
      //       // ..strokeWidth=size!
      //       // ..maskFilter=MaskFilter.blur(BlurStyle.normal, blur!)
      //       ..strokeCap=StrokeCap.round
      //       ..style=PaintingStyle.fill
      //     // ..blendMode=BlendMode.dstOut
      //     //   ..blendMode=BlendMode.darken
      // );
    }
    // canvas.transform();
    // canvas.save();
    print(lines.length);


  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // print(oldDelegate.toString());
    // TODO: implement shouldRepaint
    return true;
  }

}