
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finger_painter/finger_painter.dart';
import 'package:provider/provider.dart';
import 'package:ptp/drawing/painter_custom.dart';

import '../util/selectColor.dart';
import '../util/utilFunction.dart';
import 'ColorSelectNotifier.dart';
import 'DrawingDataNotifier.dart';
import 'drawingItem.dart';

class DrawingPage extends StatefulWidget {

  DrawingPage({ Key? key}): super(key: key);
  @override
  DrawingPageState createState() => DrawingPageState();
}

class DrawingPageState extends State<DrawingPage> {

  Image? image;
  late PainterController painterController;

  @override
  void initState() {
    super.initState();
    painterController = PainterController()
      ..setStrokeColor(Colors.black)
      ..setMinStrokeWidth(Provider.of<DrawingDataNotifier>(context, listen: false).getMinStroke)
      ..setMaxStrokeWidth(Provider.of<DrawingDataNotifier>(context, listen: false).getMaxStroke)
      ..setBlurSigma(0.0)
      ..setPenType(PenType.paintbrush2)
      ..setBlendMode(ui.BlendMode.srcOver)
    ..clearContent(clearColor: Provider.of<DrawingDataNotifier>(context, listen: false).getBackgroundColor);
  }

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;
    painterController.setMinStrokeWidth(Provider.of<DrawingDataNotifier>(context).getMinStroke);
    painterController.setMaxStrokeWidth(Provider.of<DrawingDataNotifier>(context).getMaxStroke);
    return Scaffold(
      appBar: AppBar(),
      // backgroundColor: const Color(0xffc8c8c8),
      backgroundColor: const Color(0xff555555),
      body: Column(
        children: [
          const SizedBox(height: 30),
          PainterCustom(
            controller: painterController,
            backgroundColor: Provider.of<DrawingDataNotifier>(context, listen: false).getBackgroundColor,
            // backgroundColor: const Color(0xFFF0F0F0),
            onDrawingEnded: (bytes) async {
              Provider.of<DrawingDataNotifier>(context, listen: false).addImageRam(imgBytesListData: painterController.getImageBytes());
              print('${painterController.getPoints()?.length} drawn points');
              print('${Provider.of<DrawingDataNotifier>(context, listen: false).getImageRam}');
              // print("${painterController.getImageBytes()?.length}");
              setState(() {});
            },
            size: const Size(double.infinity, 250),
            imageByte: Provider.of<DrawingDataNotifier>(context).getBackgroundImageMemory,
          ),
          const SizedBox(height: 30),
          Expanded(
            child: SingleChildScrollView(
                child: Controls(
                  pc: painterController,
                  imgBytesList: painterController.getImageBytes(),
                )),
          ),
        ],
      ),
    );
  }
}

class Controls extends StatefulWidget {
  final PainterController? pc;
  final Uint8List? imgBytesList;

  const Controls({
    Key? key,
    this.pc,
    this.imgBytesList,
  }) : super(key: key);

  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  @override

  Widget build(BuildContext context) {

    DrawingDataNotifier penColorChanger = Provider.of<DrawingDataNotifier>(context);

    double colorSelectButtonSize = (MediaQuery.of(context).size.width) / 10;

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // // display current drawing
            // if (widget.imgBytesList != null)
            //   Container(
            //     decoration: BoxDecoration(
            //       color: const Color(0x00FFFFFF),
            //       border: Border.all(
            //         color: const Color(0xFF000000),
            //         style: BorderStyle.solid,
            //         width: 4.0,
            //       ),
            //       borderRadius: BorderRadius.zero,
            //       shape: BoxShape.rectangle,
            //       boxShadow: const <BoxShadow>[
            //         BoxShadow(
            //           color: Color(0x66000000),
            //           blurRadius: 10.0,
            //           spreadRadius: 4.0,
            //         )
            //       ],
            //     ),
            //     child: Image.memory(
            //       widget.imgBytesList!,
            //       gaplessPlayback: true,
            //       fit: BoxFit.scaleDown,
            //       height: 140,
            //     ),
            //   ),
            //
            // const SizedBox(width: 30),

            // // Pen types
            // Column(
            //   children: [
            //     for (int i = 0; i < PenType.values.length; i++)
            //       OutlinedButton(
            //           child: Text(PenType.values[i].name),
            //           style: ButtonStyle(
            //               backgroundColor: widget.pc
            //                   ?.getState()
            //                   ?.penType
            //                   .index ==
            //                   i
            //                   ? MaterialStateProperty.all(
            //                   Colors.greenAccent.withOpacity(0.5))
            //                   : MaterialStateProperty.all(Colors.transparent)),
            //           onPressed: () {
            //             if (widget.pc != null) {
            //               widget.pc!.setPenType(PenType.values[i]);
            //               setState(() {});
            //             }
            //           }),
            //   ],
            // ),

            for (int i = 0; i < PenType.values.length; i++)
              Expanded(child: OutlinedButton(
                style: ButtonStyle(
                    backgroundColor: widget.pc
                        ?.getState()
                        ?.penType
                        .index ==
                        i
                        ? MaterialStateProperty.all(
                        Colors.greenAccent.withOpacity(0.5))
                        : MaterialStateProperty.all(Colors.transparent)),
                onPressed: () {
                  if (widget.pc != null) {
                    widget.pc!.setPenType(PenType.values[i]);
                    setState(() {});
                  }
                },
                child: Text(PenType.values[i].name),)),
          ],
        ),

        const SizedBox(height: 30),

        // Colors
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: ColorSelectButton(color: Colors.black, size: colorSelectButtonSize,),
                  onPressed: () => widget.pc?.setStrokeColor(Colors.black)),
              TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: ColorSelectButton(color: Colors.white, size: colorSelectButtonSize,),
                  onPressed: () => widget.pc?.setStrokeColor(Colors.white)),

              for(Color colorInQueue in Provider.of<DrawingDataNotifier>(context, listen: true).getColors)//penColorChanger.getColors
                TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: ColorSelectButton(color: colorInQueue, size: colorSelectButtonSize,),
                    onPressed: () => widget.pc?.setStrokeColor(colorInQueue)),

              ColorSelectNotifier(painterController:widget.pc, pickerColor:penColorChanger.getColor, size: colorSelectButtonSize,),

            ],
          ),
        ),

        const SizedBox(height: 10),
        // background color
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Text("background"),
              ),
            ),

            InkWell(
              onTap: ()async{
                Color temp = await selectColor(context: context);
                Provider.of<DrawingDataNotifier>(context, listen: false).setBackgroundColor(temp);
              },
              borderRadius: const BorderRadius.all(
                  Radius.circular(5)
              ),
              child: Ink(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5)
                    ),
                    gradient: SweepGradient(colors: [Colors.red, Colors.blue, Colors.yellow, Colors.red])
                ),
                width: 90,
                height: 40,
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        // background & delete
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: TextButton(
                child: Container(color: Colors.blue,child: const Icon(Icons.image, color: Colors.white,), width: double.infinity,height: 40,),
                onPressed: () async {

                  if(penColorChanger.getBackgroundImageMemory == null){
                    Uint8List memory = await getImageUint8ListFromUrl(
                        "https://www.wikihow.com/images_en/thumb/d/db/Get-the-URL-for-Pictures-Step-2-Version-6.jpg/v4-460px-Get-the-URL-for-Pictures-Step-2-Version-6.jpg");
                    penColorChanger.setBackgroundImageMemory(memory: memory);
                    return ;
                  }

                  penColorChanger.setBackgroundImageMemory(memory: null);

                  // widget.pc?.setBackgroundImage(memory);
                  // Uint8List image = (await rootBundle.load('assets/dash.png'))
                  //     .buffer
                  //     .asUint8List();
                  // widget.pc?.setBackgroundImage(image);
                  // setState(() {});

                }),),

            Expanded(child: TextButton(
                child: Container(color: Colors.green, child: const Icon(Icons.undo, color: Colors.white,), width: double.infinity, height: 40,),
                onPressed: () async {
                  Uint8List? memory = penColorChanger.undoImageRam();
                  print("${memory}");
                  if(memory == null){
                    widget.pc?.clearContent(clearColor: Provider.of<DrawingDataNotifier>(context, listen: false).getBackgroundColor);
                    return ;
                  }
                  // print(memory);
                  // Uint8List? memory = await getImageUint8ListFromUrl(
                  //     "https://www.wikihow.com/images_en/thumb/d/db/Get-the-URL-for-Pictures-Step-2-Version-6.jpg/v4-460px-Get-the-URL-for-Pictures-Step-2-Version-6.jpg");

                  print("${widget.pc?.getImageBytes() == memory}");
                  widget.pc?.setBackgroundImage(memory!);
                  // Uint8List image = (await rootBundle.load('assets/dash.png'))
                  //     .buffer
                  //     .asUint8List();
                  // widget.pc?.setBackgroundImage(image);
                  setState(() {});
                }
            ),),

            Expanded(child: TextButton(
                child: Container(color: Colors.red, child: const Icon(Icons.delete_outline, color: Colors.white,), width: double.infinity, height: 40,),
                onPressed: () => widget.pc
                    ?.clearContent(clearColor: Provider.of<DrawingDataNotifier>(context, listen: false).getBackgroundColor)),),

          ],
        ),
        const SizedBox(height: 30),

        /// min stroke width
        Row(
          children: [
            Text('  min stroke '
                '${widget.pc?.getState()!.strokeMinWidth.toStringAsFixed(1)}'),
            Expanded(
              child: Slider.adaptive(
                  value: penColorChanger.getMinStroke,//widget.pc?.getState()?.strokeMinWidth ?? 0,
                  min: 1,
                  max: 20,
                  onChanged: (value) {
                    // if (widget.pc != null) {
                    //   widget.pc?.setMinStrokeWidth(value);
                    //   if (widget.pc!.getState()!.strokeMinWidth >
                    //       widget.pc!.getState()!.strokeMaxWidth) {
                    //     widget.pc?.setMinStrokeWidth(
                    //         widget.pc!.getState()!.strokeMaxWidth);
                    //   }
                    //   setState(() {});
                    // }
                    penColorChanger.setMinStroke(value);
                  }),
            ),
          ],
        ),

        /// max stroke width
        Row(
          children: [
            Text('  max stroke '
                '${widget.pc?.getState()!.strokeMaxWidth.toStringAsFixed(1)}'),
            Expanded(
              child: Slider.adaptive(
                  value: penColorChanger.getMaxStroke,//widget.pc?.getState()?.strokeMaxWidth ?? 0,
                  min: 1,
                  max: 40,
                  onChanged: (value) {
                    // if (widget.pc != null) {
                    //   widget.pc!.setMaxStrokeWidth(value);
                    //   if (widget.pc!.getState()!.strokeMaxWidth <
                    //       widget.pc!.getState()!.strokeMinWidth) {
                    //     widget.pc!.setMaxStrokeWidth(
                    //         widget.pc!.getState()!.strokeMinWidth);
                    //   }
                    //   setState(() {});
                    // }
                    penColorChanger.setMaxStroke(value);
                  }),
            ),
          ],
        ),

        /// blur
        Row(
          children: [
            Text('  blur '
                '${widget.pc?.getState()!.blurSigma.toStringAsFixed(1)}'),
            Expanded(
              child: Slider.adaptive(
                  value: penColorChanger.getBlur,//widget.pc?.getState()?.blurSigma ?? 0,
                  min: 0.0,
                  max: 10.0,
                  onChanged: (value) {
                    // if (widget.pc != null) {
                    //   widget.pc!.setBlurSigma(value);
                    //   setState(() {});
                    // }
                    penColorChanger.setBlur(value);
                  }),
            ),
          ],
        ),

        const SizedBox(height: 30),

        // blends modes
        Wrap(
          spacing: 4,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text(' blend modes: '),
            for (int i = 0; i < ui.BlendMode.values.length; i++)
              OutlinedButton(
                  child: Text(ui.BlendMode.values[i].name),
                  style: ButtonStyle(
                      backgroundColor:
                      widget.pc?.getState()?.blendMode.index == i
                          ? MaterialStateProperty.all(
                          Colors.greenAccent.withOpacity(0.5))
                          : MaterialStateProperty.all(Colors.transparent)),
                  onPressed: () {
                    widget.pc?.setBlendMode(ui.BlendMode.values[i]);
                    setState(() {});
                  }),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
