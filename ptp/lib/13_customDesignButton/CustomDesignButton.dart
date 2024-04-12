


import 'package:flutter/material.dart';

class CustomDesignButton extends StatefulWidget {
  final String? paraString;
  const CustomDesignButton({ Key? key, this.paraString}): super(key: key);
  @override
  State<CustomDesignButton> createState() => CustomDesignButtonState();
}

class CustomDesignButtonState extends State<CustomDesignButton> {

  @override
  Widget build(BuildContext context) {
    // 디바이스 너비
    double deviceWidth = MediaQuery.of(context).size.width;
    // 디바이스 높이
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlurButton(index: 0, size: Size(30, 30), callback: (){print("aaaa");},),
          ],
        ),
      ),
    );
  }
}


class BlurButton extends StatelessWidget{

  final int index;
  final Size size;
  final VoidCallback callback;

  const BlurButton({super.key, required this.index, required this.size, required this.callback});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: callback,
      child: CustomPaint(
        size: size,
        painter: ButtonPainter(
            index: index
        ),
      ),
    );
  }
}

class ButtonPainter extends CustomPainter{

  final int index;
  const ButtonPainter({required this.index});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromCenter(center: Offset(size.width/2, size.height/2), width: size.width, height: size.height),
        Paint()
          ..style=PaintingStyle.fill
          ..maskFilter=MaskFilter.blur(BlurStyle.normal, index * 3)
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}