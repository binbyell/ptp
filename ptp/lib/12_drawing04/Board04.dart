
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptp/12_drawing04/DrawingPainterOneLine.dart';
import 'dart:math';
import 'DrawingPainter04.dart';
import 'dotInfo04.dart';
import 'notifierDrawing04.dart';
import 'dart:ui' as ui;

class Board04 extends StatefulWidget {
  final Size size;
  final GlobalKey? imgKey;
  const Board04({
    Key? key, this.imgKey,
    required this.size,
  }) : super(key: key);

  @override
  Board04State createState() => Board04State();
}

class Board04State extends State<Board04>{

  final lines = <List<DotInfo04>>[];

  DrawingPainter04? customPainter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }
  @override
  Widget build(BuildContext context) {

    // double maxOffset = [widget.size.width, widget.size.height].reduce(min);
    double maxOffset = [MediaQuery.of(context).size.width, MediaQuery.of(context).size.height].reduce(min);

    NotifierDrawing04 notifierDrawing = Provider.of<NotifierDrawing04>(context);
    NotifierDrawing04 notifierDrawingListenFalse = Provider.of<NotifierDrawing04>(context, listen: false);

    customPainter = DrawingPainter04(lines: notifierDrawing.getLines);
    // tempPainter = TempPainter(bytes: notifierDrawing.getImageRecent!);

    // TODO: implement build

    return SizedBox(
      key: widget.imgKey,
      width: widget.size.width,
      height: widget.size.height,
      // width: maxOffset,
      // height: maxOffset,
      child: Stack(
        children: [
          Positioned.fill(
            child: Stack(
              children: notifierDrawing.getLines.map((part){
                return CustomPaint(
                  foregroundPainter: DrawingPainterOneLine(lines: part),//customPainter,
                  size: widget.size,
                  // willChange: true,
                  // isComplex: true,
                );
              }).toList(),
            )
          ),

          GestureDetector(
            onPanStart: (s){
              notifierDrawingListenFalse.drawingStart(s);
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
              // notifierDrawingListenFalse.getLines.clear();
            },
            child: Container(
              decoration: BoxDecoration(
                // border: Border.all(width: 4, color: Colors.blue),
              ),
              child: Listener(

                behavior: HitTestBehavior.opaque,
                onPointerMove: (PointerEvent s){

                  // print("pointerMoveEvent isFinite ${s.localPosition}");
                  if(s.localPosition.dx > maxOffset || s.localPosition.dy > maxOffset) return;
                  if(s.localPosition.dx < 0 || s.localPosition.dy < 0 ) return;
                  if(s.kind == ui.PointerDeviceKind.stylus){
                    if(notifierDrawing.getBlur > 0){
                      notifierDrawingListenFalse.drawingUpdate(s: s);
                      return;
                    }
                    notifierDrawingListenFalse.drawingUpdate(s: s, pressure: s.pressure);
                    // lines.last.add(DotInfo(
                    //     s.localPosition,
                    //     notifierDrawing.getShowStroke * s.pressure,
                    //     notifierDrawing.getColor,
                    //     notifierDrawing.getBlur
                    // ));
                    // setState(() {});
                  }
                  else{
                    notifierDrawingListenFalse.drawingUpdate(s: s);
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
                  final recorder = ui.PictureRecorder();
                  final canvas = Canvas(recorder,
                      Rect.fromPoints(Offset(0.0, 0.0), Offset(maxOffset, maxOffset)));
                  print("onPointerUp $maxOffset");

                  /// image ram 이 비어있을 경우 비어있는 화면 저장
                  if(notifierDrawingListenFalse.getImageRam.isEmpty){
                    final recorder = ui.PictureRecorder();
                    final canvas = Canvas(recorder,
                        Rect.fromPoints(Offset(0.0, 0.0), Offset(maxOffset, maxOffset)));

                    final picture = recorder.endRecording();
                    final img = await picture.toImage(maxOffset.round(), maxOffset.round());
                    final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);
                    if(pngBytes != null){
                      notifierDrawing.addImageRam(imgBytesListData: Uint8List.view(pngBytes.buffer));
                    }
                  }

                  if(notifierDrawing.getImageRecent != null){
                    ui.Codec codec = await ui.instantiateImageCodec(notifierDrawing.getImageRecent!);
                    final frameInfo = await codec.getNextFrame();
                    canvas.drawImage(frameInfo.image, Offset(0.0, 0.0), Paint());
                  }

                  Offset? recentPoint;
                  for(DotInfo04 oneDot in notifierDrawing.getLines.last){
                    if(recentPoint == null){
                      recentPoint = oneDot.offset;
                      continue;
                    }
                    canvas.drawLine(
                        recentPoint,
                        oneDot.offset,
                        Paint()
                          ..color=oneDot.color
                          ..strokeWidth=oneDot.size
                          ..style=PaintingStyle.stroke
                          ..maskFilter=MaskFilter.blur(BlurStyle.normal, oneDot.blur)
                          ..strokeCap=StrokeCap.round
                    );
                    recentPoint = oneDot.offset;
                  }

                  final picture = recorder.endRecording();
                  final img = await picture.toImage(maxOffset.round(), maxOffset.round());
                  final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);
                  if(pngBytes != null){
                    // print("pngBytes.lengthInBytes : ${pngBytes.lengthInBytes}");
                    // showDialog(
                    //   context: context,
                    //   builder:(context){
                    //     return AlertDialog(
                    //       content: SizedBox(height: 200, width: 200, child: Image.memory(Uint8List.view(pngBytes.buffer)),),
                    //     );
                    //   }
                    // );
                    notifierDrawing.addImageRam(imgBytesListData: Uint8List.view(pngBytes.buffer));
                  }
                  // notifierDrawing.drawingEnd();
                  // print(lines.length);
                },
              ),
            )
          ),
        ],
      ),
    );

    throw UnimplementedError();
  }

}