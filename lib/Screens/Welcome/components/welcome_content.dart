import 'package:flutter/material.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/size_config.dart';


class WelcomeContent extends StatelessWidget {
  const WelcomeContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "GORESTO",
          style: TextStyle(
            fontSize: 35,
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(
          flex: 2,
        ),
        Image.asset(
          image,
          height: SizeConfig.blockSizeVertical * 50,
          width: SizeConfig.blockSizeHorizontal * 85
        ), Spacer(),
      ],
    );
  }
}
