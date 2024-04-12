
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:qr_flutter/qr_flutter.dart';

class DownQrToImgOnWeb extends StatefulWidget {
  const DownQrToImgOnWeb({ Key? key}): super(key: key);
  @override
  State<DownQrToImgOnWeb> createState() => DownQrToImgOnWebState();
}

class DownQrToImgOnWebState extends State<DownQrToImgOnWeb> {

  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // 디바이스 너비
    double deviceWidth = MediaQuery.of(context).size.width;
    // 디바이스 높이
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: globalKey,
              child: Image.asset("assets/images/bling_character.png"),
            ),
            // ui.Scene,
            TextButton(
                onPressed: ()async{
                  RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
                  ui.Image image = await boundary.toImage();
                  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                  Uint8List pngBytes = byteData!.buffer.asUint8List();


                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        if(pngBytes != null){
                          return ViewImg(widget: Image.memory(pngBytes),);
                        }
                        return Text("null");
                      }
                  );
                },
                child: Text("down")
            ),
            TextButton(
                onPressed: ()async{

                  final ui.Image image = await QrPainter(
                    data: "Hello World!",
                    gapless: true,
                    version: QrVersions.auto,
                    emptyColor: Colors.white,
                  ).toImage(1000);

                  // ui.Image image = await boundary.toImage();
                  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                  Uint8List pngBytes = byteData!.buffer.asUint8List();


                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        if(pngBytes != null){
                          return ViewImg(widget: Image.memory(pngBytes),);
                        }
                        return Text("null");
                      }
                  );
                },
                child: Text("test other")
            ),
          ],
        ),
      ),
    );
  }
}

class ViewImg extends StatelessWidget{

  final Widget widget;
  const ViewImg({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        child: widget,
      ),
    );
  }

}