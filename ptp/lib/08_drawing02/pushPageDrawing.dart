
import 'dart:math';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptp/08_drawing02/Board.dart';
import 'package:ptp/08_drawing02/DotInfo.dart';
import 'package:ptp/08_drawing02/DrawingPainter.dart';
import 'package:ptp/08_drawing02/notifierDrawing.dart';
import 'package:ptp/08_drawing02/penTypeSeletButton.dart';
import 'package:ptp/util/selectColor.dart';

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
                        Provider.of<NotifierDrawing>(context, listen: false).setPenIndex(index);
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
          Board(
            size: Size([deviceWidth, deviceHeight].reduce(min), [deviceWidth, deviceHeight].reduce(min)),
          ),
          Divider(),
          Row(
            children: [
              TextButton(
                onPressed: (){
                  notifierDrawing.undoDrawing();
                },
                child: const Text("undo"),
              ),
              TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero,shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50)))),
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: SweepGradient(colors: [Colors.red, Colors.blue, Colors.yellow, Colors.red])
                    ),
                  ),
                  onPressed: () async{
                    Color pickedColor = await selectColor(context: context, baseColor: notifierDrawing.getColor);
                    Provider.of<NotifierDrawing>(context, listen: false).setColor(pickedColor);
                  })
            ],
          ),
          /// min stroke width
          Row(
            children: [
              Text('  ${notifierDrawing.getSelectedProgress}  '
                  '${notifierDrawing.getShowStroke.toStringAsFixed(1)}'),

              Expanded(
                child: Slider.adaptive(
                    value:  notifierDrawing.getShowStroke,//widget.pc?.getState()?.strokeMinWidth ?? 0,
                    min: 1,
                    max: 40,
                    activeColor: Color(0xffff824e),
                    thumbColor: Color(0xffff824e),
                    onChanged: (value) {
                      Provider.of<NotifierDrawing>(context, listen: false).setShowStroke(value);
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
                      Provider.of<NotifierDrawing>(context, listen: false).setBlur(value);
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}
