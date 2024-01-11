
import 'package:flutter/material.dart';
import 'package:ptp/util/tempPage.dart';

class DataEditScreen extends StatefulWidget {
  // final String paraString;  required this.paraString
  const DataEditScreen({ Key? key,}): super(key: key);
  @override
  _classStateName createState() => _classStateName();
}

class _classStateName extends State<DataEditScreen> {

  int _tabIndex = 0;
  final List<Widget> _pageList = <Widget>[
    TempPagePara(paraString: "1"),
    TempPagePara(paraString: "2")
  ];

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double _device_width = MediaQuery.of(context).size.width;
    //디바이스 높이
    double _device_height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: IndexedStack(
          index: _tabIndex,
          children: _pageList,
        ),
      ),
    );
  }
}