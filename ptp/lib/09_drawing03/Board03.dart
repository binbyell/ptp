
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptp/08_drawing02/DotInfo.dart';
import 'package:ptp/08_drawing02/DrawingPainter.dart';
import 'package:ptp/09_drawing03/PainterTemp.dart';
import 'package:ptp/09_drawing03/notifierDrawing03.dart';
import 'package:ptp/util/utilFunction.dart';

class Board03 extends StatefulWidget {
  final Size size;

  const Board03({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Board03State createState() => Board03State();
}

class Board03State extends State<Board03>{

  final lines = <List<DotInfo>>[];

  DrawingPainter? customPainter;
  // TempPainter? tempPainter;
  // PictureRecorder pictureRecorder= PictureRecorder();

  // final recorder = ui.PictureRecorder();
  // final canvas = ui.Canvas(recorder, []);

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

    NotifierDrawing03 notifierDrawing = Provider.of<NotifierDrawing03>(context);
    NotifierDrawing03 notifierDrawingListenFalse = Provider.of<NotifierDrawing03>(context, listen: false);

    customPainter = DrawingPainter(lines: notifierDrawing.getLines);
    // tempPainter = TempPainter(bytes: notifierDrawing.getImageRecent!);

    // TODO: implement build

    return SizedBox(
      width: widget.size?.width ?? 0,
      height: widget.size?.height ?? 0,
      child: Stack(
        children: [

          Positioned.fill(
            child: notifierDrawing.getImageRecent!=null?Image.memory(notifierDrawing.getImageRecent!, gaplessPlayback: true,):const SizedBox(child: Text(""),),
          ),
          Positioned.fill(
            child: CustomPaint(
              // painter: tempPainter,
              foregroundPainter: customPainter,
              size: widget.size,
            ),
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
            child: Listener(

              behavior: HitTestBehavior.opaque,
              onPointerMove: (PointerEvent s){

                // print("pointerMoveEvent isFinite ${s.localPosition}");
                if(s.localPosition.dx > maxOffset || s.localPosition.dy > maxOffset) return;
                if(s.localPosition.dx < 0 || s.localPosition.dy < 0 ) return;
                if(s.kind == PointerDeviceKind.stylus){
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

                for(var oneLine in notifierDrawing.getLines){
                  Offset? recentPoint;
                  for(DotInfo oneDot in oneLine){
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
                notifierDrawing.drawingEnd();
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