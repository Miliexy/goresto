


import 'package:flutter/material.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/size_config.dart';

class AdsSection extends StatelessWidget {
  const AdsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: SizeConfig.blockSizeHorizontal * 98,
        height: SizeConfig.blockSizeVertical * 35,
        child: Padding(
          padding:
          EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
          child: PageView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 1),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              SizeConfig.blockSizeVertical * 2),
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  kPrimaryLightColor.withOpacity(0.1),
                                  BlendMode.srcATop),
                              image: AssetImage(
                                  "assets/images/fake_ad.webp"),
                              fit: BoxFit.cover)),
                    ),
                    Align(
                        alignment: Alignment(0.83, 0.88),
                        child: Container(
                          height: SizeConfig.blockSizeVertical * 4,
                          width: SizeConfig.blockSizeHorizontal * 30,
                          child: Center(
                              child: Text(
                                "Click Now!!!",
                                style: TextStyle(
                                    color: kSecondaryColor,
                                    fontSize: fontTitleSize - 15,
                                    fontWeight: FontWeight.w500),
                              )),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(
                                      SizeConfig.blockSizeVertical *
                                          1)),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(2, 1),
                                    blurRadius: 0.5,
                                    color: Colors.black38
                                        .withOpacity(0.5))
                              ],
                              color: kPrimaryColor),
                        )),
                    Material(
                      child: InkWell(
                        onTap: () {},
                        onLongPress: () {},
                      ),
                      color: Colors.transparent,
                    ),
                  ],
                ),
              );
            },
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
          ),
        ));
  }
}
