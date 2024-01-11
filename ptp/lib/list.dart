
import 'package:flutter/material.dart';
import 'package:ptp/Theme/first_screen.dart';
import 'package:ptp/util/tempPage.dart';

import 'dataEditPage/DataEditPage.dart';
import 'drawing/page_drawing.dart';

class ListScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:const Text("List Screen"),),
      body: Container(
        width:MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        child:Center(
            child:ListView(
              children: [
                OutlinedButton(
                    child: const Text("Change Theme"),
                    onPressed:(){
                      // await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Type1()));
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FirstScreen()));
                    }
                ),
                OutlinedButton(
                    child: const Text("data"),
                    onPressed:(){
                      // await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Type1()));
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DataEditScreen()));
                    }
                ),
                OutlinedButton(
                    child: const Text("drawing"),
                    onPressed:(){
                      // await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Type1()));
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DrawingPage()));
                    }
                ),
                
              ],
            )
        ),
      ),
    );
  }
}