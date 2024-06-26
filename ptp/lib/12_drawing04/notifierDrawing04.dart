


import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'dotInfo04.dart';

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


class NotifierDrawing04 extends ChangeNotifier{

  NotifierDrawing04({required Color backgroundColor}) : _backgroundColor = backgroundColor;



  // lines
  final _lines = <List<DotInfo04>>[];
  List<List<DotInfo04>> get getLines => _lines;
  // List<List<DotInfo>> getLines() => _lines;
  void drawingStart(DragStartDetails s){
    var oneLine = <DotInfo04>[];
    oneLine.add(DotInfo04(s.localPosition, _showStroke, _currentColor, _blur));
    _lines.add(oneLine);
    // notifyListeners();
  }
  void drawingUpdate({required PointerEvent s, double? pressure}){
    _lines.last.add(DotInfo04(s.localPosition, pressure==null?_showStroke:_showStroke*pressure, _currentColor, _blur));
    notifyListeners();
  }
  void drawingEnd(){

    _lines.clear();
    // notifyListeners();
  }
  void undoDrawing(){
    undoImageRam();
    try{
      _lines.removeLast();
      // notifyListeners();
    }
    on RangeError{
      //스넥바 출력시키기
    }
  }
  void clear(){
    clearImageRam();
    try{
      _lines.clear();
      // notifyListeners();
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
  double _showStroke = 1.0;
  double _pressure = 1;
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

  get getShowStroke => _showStroke;
  get getPressure => _pressure;
  double get getBlur => _blur;

  void setShowStroke(double stroke){
    _showStroke = stroke;
    // _drawingStroke = _showStroke;
    notifyListeners();
  }
  void setDrawingStroke(double pressure){
    // _drawingStroke = pressure * _showStroke;
    _pressure = pressure * 10 + 1;
    notifyListeners();
  }
  void setBlur(double blue){
    _blur = blue;
    notifyListeners();
  }

  Color get getColor => _currentColor;
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

  // void setImageRecent({Uint8List? image}){
  //   _imageRecentState = image;
  // }

  Uint8List? get getImageRecent => _imageRecentState;

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
      notifyListeners();
      return _imageRecentState;
    }
    return null;
  }
  Uint8List? clearImageRam(){
    if(_imageRam.isNotEmpty){
      _imageRam.clear();
      _imageRecentState = null;
    }
    notifyListeners();
    return null;
  }
}

abstract final class SelectedProgress{
  SelectedProgress._();

  static const String blur = '흐림';
  static const String size = "펜 굵기";
}
