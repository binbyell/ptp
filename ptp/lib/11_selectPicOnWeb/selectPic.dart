
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_web/image_picker_web.dart';

class SelectPicOnWeb extends StatefulWidget {
  final String? paraString;
  const SelectPicOnWeb({ Key? key, this.paraString}): super(key: key);
  @override
  State<SelectPicOnWeb> createState() => SelectPicOnWebState();
}

class SelectPicOnWebState extends State<SelectPicOnWeb> {

  Image? img;

  @override
  Widget build(BuildContext context) {
    // 디바이스 너비
    double deviceWidth = MediaQuery.of(context).size.width;
    // 디바이스 높이
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          img!=null?Image(image: img!.image,):SizedBox(),
          TextButton(
            onPressed: () async{
              // Image? fromPicker = await ImagePickerWeb.getImageAsWidget();
              html.File? temp = await ImagePickerWeb.getImageAsFile();

              ImageCropper().cropImage(sourcePath: temp!.name);

              print("${temp!=null?temp.name:"null"}");

              // setState(() {
              //   // img = fromPicker;
              //
              // });
            },
            child: const Text("Select Img"),
          )
        ],
      ),
    );
  }
}