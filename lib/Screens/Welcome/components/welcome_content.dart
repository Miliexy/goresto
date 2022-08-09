import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Stack(
      children: [SizedBox(
        height: SizeConfig.blockSizeVertical * 80,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:AssetImage(image),
              fit: BoxFit.cover
            )
          ),
        ),
      ),
      Positioned(left: SizeConfig.blockSizeHorizontal * 15,
      top: SizeConfig.blockSizeVertical * 30,child: SizedBox(
        width: SizeConfig.blockSizeHorizontal *80,
        child: Stack(
          children: [
            Text(text, style: GoogleFonts.amita(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style=PaintingStyle.stroke
                ..strokeWidth = 4
                ..color = const Color(0xff0c0c0c)
              ,
            ),
              textAlign: TextAlign.center
            ),
            Text(text, style: GoogleFonts.amita(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.white
              ,
            ),
                textAlign: TextAlign.center
            ),
          ],
        ),
      ),)
      ]
    );
  }
}
