

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:ptp/08_drawing02/DotInfo.dart';

class TempPainter extends CustomPainter{
  TempPainter({required this.bytes});

  Uint8List bytes;

  Canvas? tempCanvas;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // print(oldDelegate.toString());
    // TODO: implement shouldRepaint
    return true;
  }

  @override
  void paint(ui.Canvas canvas, ui.Size size) async {
    tempCanvas = canvas;
    ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final frameInfo = await codec.getNextFrame();
    // canvas.drawImageRect(frameInfo.image, Offset(0.0, 0.0), Paint());
    // TODO: implement paint
  }

}