import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goresto/size_config.dart';


class WelcomeContent extends StatelessWidget {
  const WelcomeContent({
    Key? key,
    required this.text,
    required this.image, required  this.testText,
  }) : super(key: key);
  final String text, image, testText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.blockSizeVertical * 60,
            child: Stack(
              children: [SizedBox(
                height: SizeConfig.blockSizeVertical * 60,
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
              SizedBox(
                height: SizeConfig.blockSizeVertical * 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Stack(
                        children: [
                          Text(text, style: GoogleFonts.montserratAlternates(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..style=PaintingStyle.stroke
                              ..strokeWidth = 4.5
                              ..color = const Color(0xff0c0c0c)

                            ,
                          ),
                            textAlign: TextAlign.center
                          ),
                          Text(text, style: GoogleFonts.montserratAlternates(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                            ,
                          ),
                              textAlign: TextAlign.center
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              ]
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 7, top: SizeConfig.blockSizeVertical * 2, right: SizeConfig.blockSizeHorizontal * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded( child: Stack(
                  children: [
                    Text(testText, style: GoogleFonts.montserratAlternates(fontSize: 22, fontStyle: FontStyle.italic, foreground: Paint()
                      ..style=PaintingStyle.stroke
                      ..strokeWidth = 0.5
                      ..color = const Color(0xff0c0c0c)
                      ,),),
                    Text(testText, style: GoogleFonts.montserratAlternates(fontSize: 22, fontStyle: FontStyle.italic, color: Color(
                        0xFF151212)),),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
