


import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptp/12_drawing04/penTypeSelectButton.dart';
import 'package:ptp/util/selectColor.dart';
import 'package:ptp/util/utilFunction.dart';

import 'Board04.dart';
import 'notifierDrawing04.dart';

class PushPageDrawing04 extends StatefulWidget {
  const PushPageDrawing04({ Key? key}): super(key: key);
  @override
  State<PushPageDrawing04> createState() => _PushPageDrawing04State();
}

class _PushPageDrawing04State extends State<PushPageDrawing04> {


  GlobalKey imgKey = GlobalKey();

  // final lines = <List<DotInfo>>[];
  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double deviceWidth = MediaQuery.of(context).size.width;
    //디바이스 높이
    double deviceHeight = MediaQuery.of(context).size.height;

    NotifierDrawing04 notifierDrawing = Provider.of<NotifierDrawing04>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: ()async {
              // final bytes = await getWidgetToUint8List(context: context, globalKey: imgKey);

              if(notifierDrawing.getImageRecent != null){
              // if(bytes != null){
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        content: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1)
                          ),
                          // width: [deviceWidth, deviceHeight].reduce(math.min),
                          // height: [deviceWidth, deviceHeight].reduce(math.min),
                          child:  Image.memory(notifierDrawing.getImageRecent!, ),),
                          // child:  Image.memory(bytes!, fit: BoxFit.contain,),),
                      );
                    }
                );
              }
            },
            child: Text("push"),
          )
        ],
      ),
      body: Column(
        children: [
          // select pen type
          // SizedBox(
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child: Column(
          //       children: [
          //         for(int index = 0; index < 6; index ++)
          //           AnimatedCheckSelectButton04(
          //             width: deviceWidth * 0.14,
          //             height: deviceHeight * 0.09,
          //             selectedIndex: notifierDrawing.getSelectedPenIndex,
          //             thisIndex: index,
          //             onPressed: (){
          //               Provider.of<NotifierDrawing04>(context, listen: false).setPenIndex(index);
          //             },
          //             child: Container(
          //               margin: EdgeInsets.zero,
          //               padding: EdgeInsets.zero,
          //               width: deviceWidth * 0.09,
          //               height: deviceHeight * 0.14,
          //               // child: Transform.rotate(angle: -90 * math.pi / 180, child: Image.asset(getPenImagePath(index), fit: BoxFit.fitWidth, alignment: Alignment.bottomCenter,),),
          //               child: Container(color: Colors.red,),
          //             ),
          //           )
          //       ],
          //     ),
          //   ),
          // ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 4)
            ),
            child: Board04(
              imgKey: imgKey,
              size: Size(
                  // 500,
                  // 500
                  [deviceWidth, deviceHeight].reduce(math.min),
                  [deviceWidth, deviceHeight].reduce(math.min)
                  // [deviceWidth * 0.488, deviceHeight * 0.868].reduce(math.min).round().toDouble(),
                  // [deviceWidth * 0.488, deviceHeight * 0.868].reduce(math.min).round().toDouble()
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
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
                            Provider.of<NotifierDrawing04>(context, listen: false).setShowStroke(value);
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
                            Provider.of<NotifierDrawing04>(context, listen: false).setBlur(value);
                          }),
                    )
                  ],
                ),

                TextButton(
                  onPressed: (){
                    notifierDrawing.undoDrawing();
                  },
                  child: const Text("undo"),
                ),
                TextButton(
                  onPressed: (){
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        content: Text("로그까지 싹 지워집니다. 지우시겠습니까?"),
                        actions: [

                          InkWell(
                            onTap: (){
                              if(Navigator.of(context).canPop()){
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text(
                              "취소",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "NotoSansKR",
                                  fontStyle:  FontStyle.normal,
                                  fontSize: 14.0
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              if(Navigator.of(context).canPop()){
                                notifierDrawing.clear();
                                if(Navigator.of(context).canPop()){
                                  Navigator.of(context).pop();
                                }
                              }
                            },
                            child: const Text(
                              "초기화",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "NotoSansKR",
                                  fontStyle:  FontStyle.normal,
                                  fontSize: 14.0
                              ),
                            ),
                          ),
                        ],
                      );
                    });
                  },
                  child: const Text("초기화"),
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
                      Provider.of<NotifierDrawing04>(context, listen: false).setColor(pickedColor);
                    }),
              ],
            ),
          )
          /*
          Row(
            children: [

            ],
          ),

          */
        ],
      ),
    );
  }
}
