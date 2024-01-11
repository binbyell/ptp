import 'package:flutter/material.dart';

class TempPagePara extends StatefulWidget {
  final String paraString;
  const TempPagePara({ Key? key, required this.paraString}): super(key: key);
  @override
  _classStateName createState() => _classStateName();
}

class _classStateName extends State<TempPagePara> {

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(widget.paraString),
      ),
    );
  }
}