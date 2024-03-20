
import 'package:flutter/material.dart';

class SelectInList extends StatefulWidget {

  const SelectInList({ Key? key}): super(key: key);
  @override
  State<SelectInList> createState() => SelectInListState();
}

class SelectInListState extends State<SelectInList> {

  List<TempItemForSelectInList> tempList = [
    TempItemForSelectInList(v1: "v1", v2: "1"),
    TempItemForSelectInList(v1: "v1", v2: "2"),
    TempItemForSelectInList(v1: "v2", v2: "3"),
    TempItemForSelectInList(v1: "v2", v2: "4"),
  ];

  List<TempItemForSelectInList> tempList2 = [];

  @override
  void initState() {
    for(TempItemForSelectInList item in tempList){
      tempList2.add(item);
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //디바이스 너비
    double deviceWidth = MediaQuery.of(context).size.width;
    //디바이스 높이
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: deviceWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(onPressed: onClick, child: Text('click')),
            for(TempItemForSelectInList item in tempList2)
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1)
                ),
                child: Column(
                  children: [
                    Text(item.v1),
                    Text(item.v2)
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  void onClick(){

    setState(() {

    });
  }
}


class TempItemForSelectInList{
  String v1;
  String v2;

  TempItemForSelectInList({required this.v1, required this.v2});
}
