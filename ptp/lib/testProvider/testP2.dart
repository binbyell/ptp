

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptp/testProvider/testProvider.dart';

class TempP2 extends StatefulWidget {
  const TempP2({ Key? key}): super(key: key);
  @override
  State<TempP2> createState() => _TempP2State();
}

class _TempP2State extends State<TempP2> {

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double deviceWidth = MediaQuery.of(context).size.width;
    //디바이스 높이
    double deviceHeight = MediaQuery.of(context).size.height;

    TestProvider testProvider = Provider.of<TestProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(testProvider.getTextData),
          TextButton(
            onPressed: (){
              testProvider.setTextData("TempP2");
            },
            child: Text("TempP2"),
          ),
        ],
      ),
    );
  }
}
