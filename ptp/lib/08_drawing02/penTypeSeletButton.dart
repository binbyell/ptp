
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptp/08_drawing02/notifierDrawing.dart';

class AnimatedCheckSelectButton extends StatelessWidget{
  const AnimatedCheckSelectButton({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    this.onPressed,
    this.thisIndex,
    this.selectedIndex,});

  final double width;
  final double height;
  final Widget child;
  final VoidCallback? onPressed;
  final int? selectedIndex;
  final int? thisIndex;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextButton(
      // style: TextButton.styleFrom(padding: EdgeInsets.zero,),
      onPressed: (){
        onPressed!=null?onPressed!():null;
        setPenType(index: thisIndex??0, context: context);
      },
      child: Container(
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

void setPenType({required int index, required BuildContext context}){

  switch(index){
    case 0:
      Provider.of<NotifierDrawing>(context, listen: false).setShowStroke(1);
      Provider.of<NotifierDrawing>(context, listen: false).setBlur(0);
      break;
    case 1:
      Provider.of<NotifierDrawing>(context, listen: false).setShowStroke(20);
      Provider.of<NotifierDrawing>(context, listen: false).setBlur(0);
      break;
    case 2:
      Provider.of<NotifierDrawing>(context, listen: false).setShowStroke(20);
      Provider.of<NotifierDrawing>(context, listen: false).setBlur(10);
      break;
    case 3:
      Provider.of<NotifierDrawing>(context, listen: false).setShowStroke(7.7);
      Provider.of<NotifierDrawing>(context, listen: false).setBlur(0);
      break;
    case 4:
      Provider.of<NotifierDrawing>(context, listen: false).setShowStroke(4.4);
      Provider.of<NotifierDrawing>(context, listen: false).setBlur(0);
      break;
    case 5:
      Provider.of<NotifierDrawing>(context, listen: false).setShowStroke(4);
      Provider.of<NotifierDrawing>(context, listen: false).setBlur(0);
      break;
  }
}

String getPenImagePath(int index){

  switch(index){
    case 0: return "assets/images/pen1.png";
    case 1: return "assets/images/pen2.png";
    case 2: return "assets/images/pen3.png";
    case 3: return "assets/images/pen4.png";
    case 4: return "assets/images/pen5.png";
    case 5: return "assets/images/pen6.png";
    default: return "assets/images/pen1.png";
  }
}