import 'package:flutter/material.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/size_config.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 17,
      decoration: BoxDecoration(
      ),
      child: ColorFiltered(
        colorFilter:
            ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.srcATop),
        child: Image.asset(
          "assets/logo/logo.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
