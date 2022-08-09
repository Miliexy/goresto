import 'package:flutter/material.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/size_config.dart';


class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key, required this.text, required this.press,
    required this.icon,
  }) : super(key: key);
  final String text;
  final Icon icon;
  final VoidCallback press;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: ElevatedButton(
        onPressed: press,
        style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all(kPrimaryColor),
            shape: MaterialStateProperty.all<CircleBorder>(const CircleBorder(
            ))),
        child: icon,
      ),
    );
  }
}