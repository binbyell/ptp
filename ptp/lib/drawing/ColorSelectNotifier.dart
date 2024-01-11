

import 'package:finger_painter/finger_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'DrawingDataNotifier.dart';
import 'drawingItem.dart';


class ColorSelectNotifier extends StatelessWidget{
  PainterController? painterController;
  Color pickerColor;
  double size;
  ColorSelectNotifier({ Key? key, this.painterController, this.pickerColor = Colors.black, this.size = 40}): super(key: key);

  void changeColor(Color color) {
    pickerColor = color;
  }

  @override
  Widget build(BuildContext context) {

    DrawingDataNotifier penColorChanger = Provider.of<DrawingDataNotifier>(context);

    Future<void> incrementCounter() async {
      await showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            ),
            // Use Material color picker:
            //
            // child: MaterialPicker(
            //   pickerColor: pickerColor,
            //   onColorChanged: changeColor,
            //   showLabel: true, // only on portrait mode
            // ),
            //
            // Use Block color picker:
            //
            // child: BlockPicker(
            //   pickerColor: currentColor,
            //   onColorChanged: changeColor,
            // ),
            //
            // child: MultipleChoiceBlockPicker(
            //   pickerColors: currentColors,
            //   onColorsChanged: changeColors,
            // ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                print(pickerColor);

                penColorChanger.setColor(pickerColor);
                pickerColor = penColorChanger.getColor;
                print(pickerColor);
                painterController?.setStrokeColor(pickerColor);
                // penColorChanger.addColors(pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
    }


    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero,shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50)))),
        child: Container(
          height: size,
          width: size,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(colors: [Colors.red, Colors.blue, Colors.yellow, Colors.red])
          ),
        ),
        onPressed: () {
          incrementCounter();
          painterController?.setStrokeColor(pickerColor);
        });
  }
}