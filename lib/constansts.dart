import 'package:flutter/material.dart';
import 'package:goresto/size_config.dart';

const kPrimaryColor = Color(0xFFFFFFFF);
const kPrimaryLightColor = Color(0xff000000);

const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFF1244), Color(0xFF063558)]
);
const kSecondaryColor = Color(0xff6c1cff);

const kTextColor = Color(0xff000000);

var fontTitleSize = SizeConfig.blockSizeVertical * 4;
var fontTextSize = SizeConfig.blockSizeVertical * 2;


const kAnimationDuration = Duration(milliseconds: 200);
