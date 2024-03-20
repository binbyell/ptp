
import 'dart:collection';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:ptp/drawing02/DotInfo.dart';

abstract final class BlingKeys {
  BlingKeys._();

  static GlobalKey notifierDrawingKey = GlobalKey();
  static GlobalKey notifierMemoryArtKey = GlobalKey();

}

// enum BlingKeys{
//   notifierDrawingKey('notifierDrawingKey', GlobalKey()),
//   notifierMemoryArtKey('notifierMemoryArtKey', GlobalKey());
//
//   BlingKeys(this.label, this.key);
//   final String label;
//   final GlobalKey key;
// }


class NotifierDrawing extends ChangeNotifier{

  NotifierDrawing({required Color backgroundColor}) : _backgroundColor = backgroundColor;

  // lines
  final _lines = <List<DotInfo>>[];
  List<List<DotInfo>> get getLines => _lines;
  void drawingStart(DragStartDetails s){
    var oneLine = <DotInfo>[];
    oneLine.add(DotInfo(s.localPosition, _minStroke, Colors.black, _blur));
    _lines.add(oneLine);
    notifyListeners();
  }
  void drawingUpdate(DragUpdateDetails s){
    _lines.last.add(DotInfo(s.localPosition, _minStroke, Colors.black, _blur));
    notifyListeners();
  }
  void undoDrawing(){
    try{
      _lines.removeLast();
    }
    on RangeError{
      //스넥바 출력시키기
    }
  }


  // pen index
  int _selectedPenIndex = 0;
  int get getSelectedPenIndex => _selectedPenIndex;
  void setPenIndex (int index){
    _selectedPenIndex = index;
    notifyListeners();
  }

  // Slider.adaptive 에서 어떤걸 표시 하고 있는지
  String _selectedProgress = SelectedProgress.size;
  String get getSelectedProgress =>_selectedProgress;
  void setSelectedProgress(String selectedProgress){
    _selectedProgress = selectedProgress;
    notifyListeners();
  }

  // pen type value
  double _minStroke = 1.0;
  double _maxStroke = 5.0;
  double _widthDifference = 1;
  double _blur = 0.0;

  // pen color
  Color _currentColor = const Color(0xff443a49);
  final Queue<Color> _currentColors = Queue<Color>();
  final Queue<Uint8List?> _imageRam = Queue<Uint8List>();

  // image state
  Uint8List? _imageRecentState;
  Uint8List? _backgroundImageMemory;
  Color _backgroundColor;

  // static final GlobalKey _globalKey = GlobalKey(debugLabel: "NotifierDrawing");
  static final GlobalKey _globalKey = BlingKeys.notifierDrawingKey;
  get getGlobalKeyForWork => _globalKey;

  get getMinStroke => _minStroke;
  get getMaxStroke => _maxStroke;
  double get getWidthDifference => _widthDifference;
  double get getBlur => _blur;

  void setMinStroke(double stroke){
    _setMaxStroke(stroke * _widthDifference);
    _minStroke = stroke;
    notifyListeners();
  }
  void _setMaxStroke(double stroke){
    // if(stroke <= _minStroke){
    //   _maxStroke = _minStroke;
    //   notifyListeners();
    //   return;
    // }
    print("when set max stroke, _widthDifference : $_widthDifference");
    _maxStroke = stroke;
    notifyListeners();
  }
  void setBlur(double blue){
    _blur = blue;
    notifyListeners();
  }
  void setWidthDifference(int index){
    switch(index){
      case 0:
        _widthDifference = 1;
        break;
      case 1:
        _widthDifference = 1;
        break;
      case 2:
        _widthDifference = 1;
        break;
      case 3:
        _widthDifference = 3.21;
        break;
      case 4:
        _widthDifference = 4.20;
        break;
      case 5:
        _widthDifference = 3.75;
        break;
      default:_widthDifference = 1;
    }
    _setMaxStroke(_minStroke * _widthDifference);
    notifyListeners();
  }

  get getColor => _currentColor;
  void setColor(Color pickedColor){
    _currentColor = pickedColor;
    addColors(_currentColor);
    notifyListeners();
  }

  get getColors => _currentColors;
  void addColors(Color color){
    _currentColors.addFirst(color);
    if(_currentColors.length > 3){
      _currentColors.removeLast();
    }
  }

  get getBackgroundImageMemory => _backgroundImageMemory;
  void setBackgroundImageMemory({Uint8List? memory}){
    _backgroundImageMemory = memory;
    notifyListeners();
  }

  get getBackgroundColor => _backgroundColor;
  void setBackgroundColor(Color color){
    _backgroundColor = color;
    notifyListeners();
  }

  Queue<Uint8List?> get getImageRam => _imageRam;

  void setImageRecent({Uint8List? image}){
    _imageRecentState = image;
  }

  void addImageRam({Uint8List? imgBytesListData}){
    _imageRecentState = imgBytesListData;
    if(_imageRam.length > 20){
      _imageRam.removeLast();
    }
    _imageRam.addFirst(imgBytesListData);
    notifyListeners();
  }
  Uint8List? undoImageRam(){
    if(_imageRam.isNotEmpty){
      _imageRam.removeFirst();
    }
    if(_imageRam.isNotEmpty){
      _imageRecentState = _imageRam.first;
      return _imageRecentState;
    }
    return null;
  }
}

abstract final class SelectedProgress{
  SelectedProgress._();

  static const String blur = '흐림';
  static const String size = "펜 굵기";
}
