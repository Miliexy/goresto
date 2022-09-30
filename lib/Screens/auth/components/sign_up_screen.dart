import 'package:flutter/material.dart';
import 'package:goresto/Screens/auth/components/login_screen.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/size_config.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

        child: SizedBox(
          child: CustomPaint(
            painter: CurvePainter(),
            child: Padding(
              padding:  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 8.0, right: SizeConfig.blockSizeHorizontal * 8),
              child: Column(
                children: [
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 76,
                    height: SizeConfig.blockSizeVertical * 25,
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
                  SizedBox(height: SizeConfig.blockSizeVertical * 1.5,),
                  TextFormField(
                    showCursor: false,
                    decoration: InputDecoration(
                      label: Text("Email"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)
                      )
                    ),
                    onTap: () {
                    },
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1.5,),
                  TextFormField(
                    showCursor: false,
                    decoration: InputDecoration(
                        label: Text("First Name"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)
                        )
                    ),
                    onTap: () {
                    },
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1.5,),
                  TextFormField(
                    showCursor: false,
                    decoration: InputDecoration(
                        label: Text("Last Name"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)
                        )
                    ),
                    onTap: () {
                    },
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1.5,),
                  TextFormField(
                    showCursor: false,
                    decoration: InputDecoration(
                        label: Text("Phone Number"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)
                        )
                    ),
                    onTap: () {
                    },
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1.5,),
                  TextFormField(
                    showCursor: false,
                    decoration: InputDecoration(
                        label: Text("Password"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)
                        )
                    ),
                    onTap: () {
                    },
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1.5,),
                  TextFormField(
                    showCursor: false,
                    decoration: InputDecoration(
                        label: Text("Confrim Password"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)
                        )
                    ),
                    onTap: () {
                    },
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1.5,),
                  ElevatedButton(onPressed: (){}, child: Text("Sign Up", style: TextStyle(fontSize: 19),), style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(SizeConfig.blockSizeHorizontal * 45, SizeConfig.blockSizeVertical * 5))
                  ),),
                  TextButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
                  }, child: Text("or Log In"), style: Theme.of(context).textButtonTheme.style,),
                ],
              ),
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
