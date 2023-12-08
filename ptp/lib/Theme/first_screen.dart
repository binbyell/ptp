import 'package:flutter/material.dart';
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
              child:OutlinedButton(
                  child:Text("Press me"),
                  onPressed:(){
                    _themeProvider.setTheme(_themeProvider.getTheme==lightTheme?darkTheme:lightTheme);
                  }
                  )
      ),
    ),
    );
  }
}