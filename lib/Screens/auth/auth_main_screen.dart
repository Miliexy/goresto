import 'package:flutter/material.dart';
import 'package:goresto/Screens/auth/components/sign_up_screen.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/size_config.dart';

class AuthMainScreen extends StatelessWidget {
  const AuthMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: SizeConfig.blockSizeVertical * 100,
        width: SizeConfig.blockSizeHorizontal * 100,
        child: CustomPaint(
          painter: CurvePainter(),
          child: Padding(
            padding:  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 8.0, right: SizeConfig.blockSizeHorizontal * 8),
            child: Column(
              children: [
                Container(
                  width: SizeConfig.blockSizeHorizontal * 76,
                  child: ShaderMask(
                    child: Image.asset("assets/logo/logo.png"),
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0.0,
                          0.80,
                        ],
                        colors: [
                          Colors.white,
                          kSecondaryColor
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcATop,
                  ),
                ),
                Text("Create your account for the best Experience", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25, color: kSecondaryColor),),
                SizedBox(height: SizeConfig.blockSizeVertical * 3,),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen(),));
                }, child: Text("Sign UP"), style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(SizeConfig.blockSizeHorizontal * 80,SizeConfig.blockSizeVertical * 5))
                ),),
                SizedBox(height: SizeConfig.blockSizeVertical * 3,),

                TextButton(onPressed: (){}, child: Text("or Log In"), style: Theme.of(context).textButtonTheme.style,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = kSecondaryColor;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.212156,
        size.width * 0.5, size.height * 0.25);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.28551,
        size.width * 1.0, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}
