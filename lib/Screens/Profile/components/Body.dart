import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/routes.dart';
import 'package:goresto/size_config.dart';
import 'package:sliver_tools/sliver_tools.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 100,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            "LOGO",
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 30,
          ),
          const Text(
            "Create your account for the best experience and managing your reservations.",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          AuthButtonGroup(
            buttons: [
              FacebookAuthButton(
                onPressed: () {
                  setState(() {
                    Navigator.pushNamed(context, AppRouter.profileRoute);
                  });
                },
              ),
              GoogleAuthButton(
                onPressed: () {},
              ),
              AppleAuthButton(
                onPressed: () {},
              ),
            ],
            spacing: SizeConfig.blockSizeVertical * 5,
            direction: VerticalDirection.up,
            style: AuthButtonStyle(
              width: SizeConfig.blockSizeHorizontal * 70,
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text("something something EULA"),
          )
        ],
      ),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverPinnedHeader(
                child: Container(
                  height: SizeConfig.blockSizeVertical * 25,
                  color: Colors.white,

                  child: Stack(
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 5,
                              right: SizeConfig.blockSizeHorizontal * 2),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  radius: SizeConfig.blockSizeVertical * 5,
                                  backgroundColor: kPrimaryColor,
                                  backgroundImage:
                                  AssetImage("assets/images/user_avatar.png")),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 3),
                                child: Text(
                                  "Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: fontTitleSize),
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                        ),
                      )
                    ],
                  ),
                ))
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildContactUs(),
              buildSettings(),
              buildAboutApp(),
              SizedBox(height: AppBar().preferredSize.height / 2,)
            ],
          ),
        ));
  }

  Column buildContactUs() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5,
              bottom: SizeConfig.blockSizeVertical * 2,
              top: SizeConfig.blockSizeVertical * 5),
          child: Row(
            children: [
              Text(
                "Contact US",
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: fontTextSize),
              )
            ],
          ),
        ),

        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.symmetric(horizontal: 12),
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              const ListTile(
                leading: Icon(Icons.chat),
                title: Text('Live Chat'),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('Email us'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column buildSettings() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5,
              bottom: SizeConfig.blockSizeVertical * 2,
              top: SizeConfig.blockSizeVertical * 5),
          child: Row(
            children: [
              Text(
                "Contact US",
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: fontTextSize),
              )
            ],
          ),
        ),

        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.symmetric(horizontal: 12),
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              const ListTile(
                leading: Icon(Icons.translate),
                title: Text('Live Chat'),
              ),
              ListTile(
                leading: Icon(Icons.notifications_active),
                title: Text('Email us'),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Column buildAboutApp() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5,
              bottom: SizeConfig.blockSizeVertical * 2,
              top: SizeConfig.blockSizeVertical * 5),
          child: Row(
            children: [
              Text(
                "Goresto",
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: fontTextSize),
              )
            ],
          ),
        ),

        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.symmetric(horizontal: 12),
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              const ListTile(
                leading: Icon(Icons.star),
                title: Text('Rate us'),
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip),
                title: Text('Privacy policy'),
              ),
              ListTile(
                leading: Icon(Icons.copyright_sharp),
                title: Text('About us'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
