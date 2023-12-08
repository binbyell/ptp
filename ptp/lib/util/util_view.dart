
import 'package:flutter/material.dart';

Widget utilButton({required GestureTapCallback callback, required String text}){
  return InkWell(
  onTap: callback,
  child: Ink(
    width: 200,
    height: 100,
    color: Colors.grey,
    child: Center(child: Text(text),),
  ),
  );
}

