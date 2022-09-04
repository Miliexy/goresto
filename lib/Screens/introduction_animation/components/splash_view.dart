import 'package:flutter/material.dart';
import 'package:goresto/constansts.dart';

import '../../../size_config.dart';

class SplashView extends StatefulWidget {
  final AnimationController animationController;

  const SplashView({Key? key, required this.animationController})
      : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    final _introductionanimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _introductionanimation,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(

                child: Image.asset(
                  'assets/images/waiter.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text(

                  "Clearhead",
                  style: TextStyle(fontSize: fontTitleSize, fontWeight: FontWeight.bold, color: kTextColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 64, right: 64),
                child: Text(
                  "Lorem ipsum dolor sit amet,consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore",
                  textAlign: TextAlign.center, style: TextStyle(color: kTextColor, fontSize: fontTextSize),
                ),
              ),
              SizedBox(
                height: 48,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 16),
                child: InkWell(
                  onTap: () {
                    widget.animationController.animateTo(0.2);
                  },
                  child: Container(
                    constraints: BoxConstraints(maxHeight: SizeConfig.blockSizeVertical * 5),
                    padding: EdgeInsets.only(
                      left: 56.0,
                      right: 56.0,
                      top: SizeConfig.blockSizeVertical * 1,
                      bottom: SizeConfig.blockSizeVertical * 1,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(38.0),
                      color: kSecondaryColor,
                    ),
                    child: Text(
                      "Let's begin",
                      style: TextStyle(

                        fontSize: SizeConfig.blockSizeVertical * 2.3,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
