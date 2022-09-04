
import 'package:flutter/material.dart';
import 'package:goresto/Screens/testData/dataList.dart';

import '../../../constansts.dart';

class ButtonUi extends StatefulWidget {
  final data;

  const ButtonUi({Key? key, required this.data} ) : super(key: key);

  @override
  State<ButtonUi> createState() => _ButtonUiState();
}

class _ButtonUiState extends State<ButtonUi> {

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          border: Border.all(color: kSecondaryColor)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white24,
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 12, bottom: 12, left: 18, right: 18),
            child: Center(
              child: Text(
                widget.data,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: fontTextSize,
                  letterSpacing: 0.27,
                  color: kSecondaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
