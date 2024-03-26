
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/gestures.dart';
// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptp/08_drawing02/DotInfo.dart';
import 'package:ptp/08_drawing02/DrawingPainter.dart';
import 'package:ptp/08_drawing02/notifierDrawing.dart';
import 'package:ptp/util/utilFunction.dart';

class Board extends StatefulWidget {
  final Size size;

  const Board({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  BoardState createState() => BoardState();
}

class BoardState extends State<Board>{

  final lines = <List<DotInfo>>[];

  DrawingPainter? customPainter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }
  @override
  Widget build(BuildContext context) {

    double maxOffset = [MediaQuery.of(context).size.width, MediaQuery.of(context).size.height].reduce(min);

    NotifierDrawing notifierDrawing = Provider.of<NotifierDrawing>(context);

    customPainter = DrawingPainter(lines: notifierDrawing.getLines,);

    // TODO: implement build

    return SizedBox(
      width: widget.size?.width ?? 0,
      height: widget.size?.height ?? 0,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              key: notifierDrawing.getGlobalKeyForWork,
              painter: customPainter,//DrawingPainter(lines: notifierDrawing.getLines),
              size: widget.size,
            ),
            // child: Canvas(
            //
            // ),
          ),
          GestureDetector(
            onPanStart: (s){
              Provider.of<NotifierDrawing>(context, listen: false).drawingStart(s);
              // var oneLine = <DotInfo>[];
              // oneLine.add(DotInfo(
              //     s.localPosition,
              //     notifierDrawing.getShowStroke, notifierDrawing.getColor, notifierDrawing.getBlur));
              // lines.add(oneLine);
            },
            onPanUpdate: (DragUpdateDetails s){
              // notifierDrawing.drawingUpdate(s: s);
            },
            onPanEnd: (DragEndDetails s){
              // print("DragEndDetails - $s");
              // Provider.of<NotifierDrawing>(context, listen: false).getLines.clear();
            },
            child: Listener(

              behavior: HitTestBehavior.opaque,
              onPointerMove: (PointerEvent s){

                // print("pointerMoveEvent isFinite ${s.localPosition}");
                if(s.localPosition.dx > maxOffset || s.localPosition.dy > maxOffset) return;
                if(s.localPosition.dx < 0 || s.localPosition.dy < 0 ) return;
                if(s.kind == PointerDeviceKind.stylus){
                  if(Provider.of<NotifierDrawing>(context).getBlur > 0){
                    Provider.of<NotifierDrawing>(context, listen: false).drawingUpdate(s: s);
                    return;
                  }
                  Provider.of<NotifierDrawing>(context, listen: false).drawingUpdate(s: s, pressure: s.pressure);
                  // lines.last.add(DotInfo(
                  //     s.localPosition,
                  //     notifierDrawing.getShowStroke * s.pressure,
                  //     notifierDrawing.getColor,
                  //     notifierDrawing.getBlur
                  // ));
                  // setState(() {});
                }
                else{
                  Provider.of<NotifierDrawing>(context, listen: false).drawingUpdate(s: s);
                  // lines.last.add(DotInfo(
                  //     s.localPosition,
                  //     notifierDrawing.getShowStroke,
                  //     notifierDrawing.getColor,
                  //     notifierDrawing.getBlur
                  // ));
                  // setState(() {});
                }
              },
              onPointerUp: (s) async{
                // Uint8List? imageBytes = await getWidgetToUint8List(context: context, globalKey: notifierDrawing.getGlobalKeyForWork);
                // notifierDrawing.addImageRam(imgBytesListData: imageBytes);
                // notifierDrawing.drawingEnd();
                // print(lines.length);
              },
            ),
          ),
        ],
      ),
    );

    throw UnimplementedError();
  }

}