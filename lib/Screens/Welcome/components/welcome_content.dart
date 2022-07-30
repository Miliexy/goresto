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
            fontSize: getProportionateScreenWidth(120),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        Spacer(
          flex: 2,
        ),
        Image.asset(
          image,
          height: getProportionateScreenHeight(300),
          width: getProportionateScreenWidth(600),
        ), Spacer(),
      ],
    );
  }
}
