
import 'package:flutter/material.dart';

class TempPagePara extends StatefulWidget {
  final String? paraString;
  const TempPagePara({ Key? key, this.paraString}): super(key: key);
  @override
  State<TempPagePara> createState() => TempPageParaState();
}

class TempPageParaState extends State<TempPagePara> {

  @override
  Widget build(BuildContext context) {
    // 디바이스 너비
    double deviceWidth = MediaQuery.of(context).size.width;
    // 디바이스 높이
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(widget.paraString??""),
      ),
    );
  }
}