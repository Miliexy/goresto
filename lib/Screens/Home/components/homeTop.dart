import 'package:flutter/material.dart';
import 'package:goresto/size_config.dart';

class HomeTop extends StatelessWidget {
  const HomeTop({
    Key? key, required this.image,
  }) : super(key: key);
  final AssetImage image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 35,
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.cover
                )
              ),
            ),
            const Center(
              child: Text(
                "Découvrez les restaurants au Maroc",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}