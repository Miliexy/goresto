
import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goresto/size_config.dart';

class AnimatedDialog extends StatefulWidget {
  const AnimatedDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedDialog> createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.bounceInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              width: SizeConfig.blockSizeHorizontal * 80,
              height: SizeConfig.blockSizeVertical * 50,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Padding(
                    padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
                    child: SizedBox(
                      height: SizeConfig.blockSizeVertical * 10,
                      width: SizeConfig.blockSizeHorizontal * 60,
                      child: Text("Sign In With One Click", style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ),
                  ),
                  AuthButtonGroup(
                    style: AuthButtonStyle(
                      width: SizeConfig.blockSizeHorizontal * 50,
                      margin: EdgeInsets.only(bottom: 8.0),
                    ),
                    buttons: [
                      GoogleAuthButton(onPressed: () {}),
                      AppleAuthButton(
                        onPressed: () {},
                      ),
                      FacebookAuthButton(onPressed: () {}),
                      TwitterAuthButton(onPressed: () {})
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 10,
                    child: TextButton(child: Text("Skip", style: GoogleFonts.montserrat(fontSize: 18,),), onPressed: (){
                    },),
                  )
                ],
              )),
        ),
      ),
    );
  }
}