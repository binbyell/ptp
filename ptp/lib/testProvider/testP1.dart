

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptp/testProvider/testProvider.dart';

class TempP1 extends StatefulWidget {
  const TempP1({ Key? key}): super(key: key);
  @override
  State<TempP1> createState() => _TempP1State();
}

class _TempP1State extends State<TempP1> {
  double temp = 0;
  int indexTemp = 0;

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double deviceWidth = MediaQuery.of(context).size.width;
    //디바이스 높이
    double deviceHeight = MediaQuery.of(context).size.height;



    // TestProvider testProvider = Provider.of<TestProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text(testProvider.getTextData),
          TextButton(
            onPressed: (){
              // testProvider.setTextData("TempP1");
              setState(() {
                temp-=10;
              });
            },
            child: Text("TempP1"),
          ),
          AnimatedCheckSelectButton(
            width: 40,
            height: 100,
            onPressed: (){
              setState(() {
                indexTemp == 0?indexTemp = 1:indexTemp = 0;
              });
            },
            thisIndex: 0,
            selectedIndex: indexTemp,
            child: Container(width: 40, height: 100, decoration: BoxDecoration(color: Colors.red),),
          ),
          AnimatedCheckSelectButton(
            width: 40,
            height: 100,
            onPressed: (){
              setState(() {
                indexTemp == 0?indexTemp = 1:indexTemp = 0;
              });
            },
            thisIndex: 1,
            selectedIndex: indexTemp,
            child: Container(width: 40, height: 100, decoration: BoxDecoration(color: Colors.red),),
          ),
        ],
      ),
    );
  }
}

class AnimatedCheckSelectButton extends StatelessWidget{
  const AnimatedCheckSelectButton({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    required this.onPressed,
    this.thisIndex,
    this.selectedIndex});

  final double width;
  final double height;
  final Widget child;
  final VoidCallback onPressed;
  final int? selectedIndex;
  final int? thisIndex;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextButton(
      onPressed: onPressed,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              bottom: selectedIndex==thisIndex
                  ?0
                  :height * 0.3,
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
