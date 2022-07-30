import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientations;

  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  //text size

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientations = _mediaQueryData.orientation;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}
  double getProportionateScreenHeight(double inputHeight){
    double screenHeight = SizeConfig.screenHeight;
    return (inputHeight/812.0)*screenHeight;
  }

  double getProportionateScreenWidth(double inputWidth){
    double screenWidth= SizeConfig.screenWidth;
    return (inputWidth/812.0)*screenWidth;
  }
