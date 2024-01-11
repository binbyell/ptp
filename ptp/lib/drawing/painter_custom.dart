
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:finger_painter/finger_painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DrawingDataNotifier.dart';

class PainterCustom extends StatefulWidget {
  final Widget? child;
  final Color backgroundColor;
  final Size? size;
  final Function(Uint8List? imgBytes)? onDrawingEnded;
  final Uint8List? imageByte;

  // painter controller
  final PainterController? controller;

  const PainterCustom({
    Key? key,
    this.child,
    this.backgroundColor = Colors.transparent,
    this.size,
    this.controller,
    this.onDrawingEnded,
    this.imageByte
  }) : super(key: key);

  @override
  PainterCustomState createState() => PainterCustomState();
}

class PainterCustomState extends State<PainterCustom>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SizedBox(
      width: widget.size?.width ?? 0,
      height: widget.size?.height ?? 0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: widget.size?.width ?? 0,
            height: widget.size?.height ?? 0,
            child: widget.imageByte==null?null:Image.memory(widget.imageByte!, fit: BoxFit.cover,),
          ),
          Painter(
            key: widget.key,
            backgroundColor: widget.backgroundColor,
            size: widget.size,
            controller: widget.controller,
            onDrawingEnded: widget.onDrawingEnded,
            child: widget.child,
          )
        ],
      ),
    );

    throw UnimplementedError();
  }

}