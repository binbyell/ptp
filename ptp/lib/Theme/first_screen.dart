import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:ptp/Theme/theme_changer.dart';

class FirstScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    var _themeProvider=Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(title:Text("First Screen"),),
      body:Container(width:MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height,
          child:Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      child:Text("Press me"),
                      onPressed:(){
                        // _themeProvider.setTheme(_themeProvider.getTheme==lightTheme?darkTheme:lightTheme);

                        ThemeData temp = ThemeData(
                          appBarTheme: AppBarTheme(
                            color: _themeProvider.getColor,
                          ),
                        );

                        _themeProvider.setTheme(temp);
                      }
                  ),

                  ColorChanger(pickerColor: _themeProvider.getColor,),
                ],
              )
      ),
    ),
    );
  }
}

class ColorChanger extends StatelessWidget{
  Color pickerColor;
  ColorChanger({ Key? key, required this.pickerColor}): super(key: key);

  void changeColor(Color color) {
    pickerColor = color;
  }

  @override
  Widget build(BuildContext context) {

    final themeChanger = Provider.of<ThemeChanger>(context);



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
                themeChanger.setColor(pickerColor);
                pickerColor = themeChanger.getColor;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
    }


    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Text("appbar"),
          ),
        ),
        Material(
          child: InkWell(
            borderRadius: const BorderRadius.all(
                Radius.circular(5)
            ),
            // style: TextButton.styleFrom(
            //     padding: EdgeInsets.zero
            // ),
            onTap: () async {
              await incrementCounter();
            },
            child: Ink(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(5)
                  ),
                color: themeChanger.getColor,
              ),
              width: 90,
              height: 40,
            ),
          ),

        ),
      ],
    );
  }
}