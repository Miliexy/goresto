
import 'package:flutter/material.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/size_config.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4, left: SizeConfig.blockSizeHorizontal * 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Choose your',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: fontTextSize,
                    letterSpacing: 0.2,
                    color: kPrimaryColor,
                  ),
                ),
                Text(
                  'Nos Restaurant',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontTitleSize,
                    letterSpacing: 0.27,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
