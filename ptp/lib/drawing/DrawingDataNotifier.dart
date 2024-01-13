
import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class DrawingDataNotifier extends ChangeNotifier {

  DrawingDataNotifier({required Color backgroundColor}) : _backgroundColor = backgroundColor;

  // pen type value
  double _minStroke = 1.0;
  double _maxStroke = 5.0;
  double _blur = 0.0;

  // pen color
  Color _currentColor = const Color(0xff443a49);
  final Queue<Color> _currentColors = Queue<Color>();
  final Queue<Uint8List?> _imageRam = Queue<Uint8List>();

  // image state
  Uint8List? _imageRecentState;
  Uint8List? _backgroundImageMemory;
  Color _backgroundColor;

  get getMinStroke => _minStroke;
  get getMaxStroke => _maxStroke;
  get getBlur => _blur;

  void setMinStroke(double stroke){
    if(stroke >= _maxStroke){
      _minStroke = _maxStroke;
      notifyListeners();
      return;
    }
    _minStroke = stroke;
    notifyListeners();
  }
  void setMaxStroke(double stroke){
    if(stroke <= _minStroke){
      _maxStroke = _minStroke;
      notifyListeners();
      return;
    }
    _maxStroke = stroke;
    notifyListeners();
  }
  void setBlur(double blue){
    _blur = blue;
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

  get getImageRam => _imageRam;

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