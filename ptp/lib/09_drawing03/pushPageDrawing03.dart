
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptp/09_drawing03/notifierDrawing03.dart';
import 'package:ptp/08_drawing02/penTypeSeletButton.dart';
import 'package:ptp/09_drawing03/Board03.dart';
import 'package:ptp/util/selectColor.dart';

class PushPageDrawing03 extends StatefulWidget {
  const PushPageDrawing03({ Key? key}): super(key: key);
  @override
  State<PushPageDrawing03> createState() => _PushPageDrawing03State();
}

class _PushPageDrawing03State extends State<PushPageDrawing03> {

  // final lines = <List<DotInfo>>[];
  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double deviceWidth = MediaQuery.of(context).size.width;
    //디바이스 높이
    double deviceHeight = MediaQuery.of(context).size.height;

    NotifierDrawing03 notifierDrawing = Provider.of<NotifierDrawing03>(context);

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
                        Provider.of<NotifierDrawing03>(context, listen: false).setPenIndex(index);
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
          Board03(
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
                    Provider.of<NotifierDrawing03>(context, listen: false).setColor(pickedColor);
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
                      Provider.of<NotifierDrawing03>(context, listen: false).setShowStroke(value);
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
                      Provider.of<NotifierDrawing03>(context, listen: false).setBlur(value);
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}
