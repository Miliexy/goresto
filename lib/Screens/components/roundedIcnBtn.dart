
import 'package:flutter/material.dart';

class RoundedIcnBtn extends StatelessWidget {
  const RoundedIcnBtn({
    Key? key, required this.iconData, required this.press, required this.opacity,
  }) : super(key: key);

  final double opacity;

  final IconData iconData;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: press,
      style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(opacity)),
          fixedSize: MaterialStateProperty.all(const Size.fromRadius(13)),
          shape: MaterialStateProperty.all(const CircleBorder(
          ))
      ),
      child: Icon(iconData, color: Colors.black,),
    );
  }
}
