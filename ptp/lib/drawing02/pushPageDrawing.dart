
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptp/drawing02/DotInfo.dart';
import 'package:ptp/drawing02/notifierDrawing.dart';
import 'package:ptp/drawing02/penTypeSeletButton.dart';

class PushPageDrawing extends StatefulWidget {
  const PushPageDrawing({ Key? key}): super(key: key);
  @override
  State<PushPageDrawing> createState() => _PushPageDrawingState();
}

class _PushPageDrawingState extends State<PushPageDrawing> {

  // final lines = <List<DotInfo>>[];
  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double deviceWidth = MediaQuery.of(context).size.width;
    //디바이스 높이
    double deviceHeight = MediaQuery.of(context).size.height;

    NotifierDrawing notifierDrawing = Provider.of<NotifierDrawing>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // select pen type
          SizedBox(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for(int index = 0; index < 6; index ++)
                    AnimatedCheckSelectButton(
                      width: deviceWidth * 0.09,
                      height: deviceHeight * 0.14,
                      selectedIndex: notifierDrawing.getSelectedPenIndex,
                      thisIndex: index,
                      onPressed: (){
                        notifierDrawing.setPenIndex(index);
                      },
                      child: Container(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        width: deviceWidth * 0.09,
                        height: deviceHeight * 0.14,
                        child: Image.asset(getPenImagePath(index), fit: BoxFit.fitWidth, alignment: Alignment.bottomCenter,),
                      ),
                    )
                ],
              ),
            ),
          ),
          Divider(),
          Container(
            height: [deviceWidth, deviceHeight].reduce(min),
            width: [deviceWidth, deviceHeight].reduce(min),
            // decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: DrawingPainter(notifierDrawing.getLines),
                  ),
                ),
                GestureDetector(
                  onPanStart: (s){
                    notifierDrawing.drawingStart(s);
                  },
                  onPanUpdate: (s){
                    notifierDrawing.drawingUpdate(s);
                  },
                ),
              ],
            ),
          ),
          Divider(),
          TextButton(
            onPressed: (){
              notifierDrawing.undoDrawing();
            },
            child: const Text("undo"),
          ),
          /// min stroke width
          Row(
            children: [
              Text('  ${notifierDrawing.getSelectedProgress}  '
                  '${notifierDrawing.getMinStroke.toStringAsFixed(1)}'),

              Expanded(
                child: Slider.adaptive(
                    value:  notifierDrawing.getMinStroke,//widget.pc?.getState()?.strokeMinWidth ?? 0,
                    min: 1,
                    max: 40,
                    activeColor: Color(0xffff824e),
                    thumbColor: Color(0xffff824e),
                    onChanged: (value) {
                      notifierDrawing.setMinStroke(value);
                    }),
              ),
            ],
          ),
          Row(
            children: [
              Text('  블러  '
                  '${notifierDrawing.getBlur.toStringAsFixed(1)}'),

              Expanded(
                child: Slider.adaptive(
                    value:  notifierDrawing.getBlur,//widget.pc?.getState()?.strokeMinWidth ?? 0,
                    min: 0,
                    max: 40,
                    activeColor: Color(0xffff824e),
                    thumbColor: Color(0xffff824e),
                    onChanged: (value) {
                      notifierDrawing.setBlur(value);
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class DrawingPainter extends CustomPainter{
  DrawingPainter(this.lines);
  final List<List<DotInfo>> lines;
  @override
  void paint(Canvas canvas, Size size) {
    for(var oneLine in lines){
      Color? color;
      double? size;
      double? blur;
      var l = <Offset>[];
      var p = Path();
      for(DotInfo oneDot in oneLine){
        color ??= oneDot.color;
        size ??= oneDot.size;
        blur ??= oneDot.blur;
        l.add(oneDot.offset);
      }
      p.addPolygon(l, false);
      canvas.drawPath(
          p,
          Paint()
            ..color = color!
            ..strokeWidth=size!
            ..maskFilter=MaskFilter.blur(BlurStyle.normal, blur!)
            ..strokeCap=StrokeCap.round
            ..style=PaintingStyle.stroke
            // ..blendMode=BlendMode.dstOut
            ..blendMode=BlendMode.darken
      );
    }
    // print("dot Info lines Start");
    // for(var oneLine in lines){
    //   print("dot Info oneLine Start");
    //   for(var oneDot in oneLine){
    //     // print("dot Info oneDot \nsize:${oneDot.size}\nsize:${oneDot.offset}");
    //   }
    //   print("dot Info oneLine Start");
    // }
    // print("dot Info lines End");
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}