
import 'package:flutter/cupertino.dart';

class ColorSelectButton extends StatelessWidget{
  final double size;
  final Color color;
  const ColorSelectButton({super.key, required this.color, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      width: size, height: size,
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}