
import 'package:flutter/material.dart';
import 'package:ptp/SelectInList/selectInList.dart';
import 'package:ptp/Theme/first_screen.dart';
import 'package:ptp/checkProgress/progress.dart';
import 'package:ptp/drawing02/pushPageDrawing.dart';
import 'package:ptp/testProvider/testP1.dart';
import 'package:ptp/testProvider/testP2.dart';
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
                OutlinedButton(
                    child: const Text("checkProgress"),
                    onPressed:(){
                      // await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Type1()));
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckProgress()));
                    }
                ),
                OutlinedButton(
                    child: const Text("testP1"),
                    onPressed:(){
                      // await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Type1()));
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const TempP1()));
                    }
                ),
                OutlinedButton(
                    child: const Text("testP2"),
                    onPressed:(){
                      // await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Type1()));
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const TempP2()));
                    }
                ),
                OutlinedButton(
                    child: const Text("SelectInList"),
                    onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const SelectInList()));
                    }
                ),
                OutlinedButton(
                    child: const Text("drawing02"),
                    onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const PushPageDrawing()));
                    }
                ),
              ],
            )
        ),
      ),
    );
  }
}