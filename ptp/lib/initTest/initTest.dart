
import 'package:flutter/cupertino.dart';

class InitProvider extends ChangeNotifier{

  var _temp;
  InitProvider.instance() {
    print("ajiajsfioasfjio");
    // print(_temp);
    // print(_temp);
    // print(_temp);
    notifyListeners();
  }
}