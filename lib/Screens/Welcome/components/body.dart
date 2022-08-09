import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goresto/Screens/Locations/location_screen.dart';
import 'package:goresto/Screens/components/animatedDialog.dart';
import 'package:goresto/Screens/components/default_button.dart';
import 'package:goresto/Services/location.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/routes.dart';
import 'package:goresto/size_config.dart';

import 'welcome_content.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GetLocation getLocation = GetLocation();
  List<Placemark>? _placemark;
  int currentPage = 0;
  List<Map<String, String>> welcomeData = [
    {
      "text": 'Découvrez les restaurants au Maroc',
      "image": "assets/images/fine-dining2.jpg"
    },
    {
      "text": "Trouver le meilleur restaurant où manger au Maroc",
      "image": "assets/images/fine-dining3.jpg"
    },
    {"text": "hello world 3", "image": "assets/images/fine-dining1.jpg"},
  ];

  late final PageController _pageController = PageController(initialPage: 0);

  var height = SizeConfig.blockSizeVertical * 100;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: welcomeData.length,
              itemBuilder: (context, index) => WelcomeContent(
                image: welcomeData[index]["image"].toString(),
                text: welcomeData[index]["text"].toString(),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AnimatedDialog();
                              });
                        },
                        style: ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 70)),
                            shape: MaterialStateProperty.all(
                                const CircleBorder()),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.grey.withOpacity(0.05))),
                        child: const Text(
                          'Skip',
                          style:
                              TextStyle(color: Colors.black, fontSize: 25),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(welcomeData.length,
                          (index) => buildDot(index: index)),
                    ),
                  ),
                  Expanded(
                    child: DefaultButton(
                        text: "text",
                        icon: const Icon(Icons.arrow_forward_sharp),
                        press: () {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                          //redirect to home screen if last page
                          if (currentPage == welcomeData.length - 1) {
                            Navigator.of(context).pushAndRemoveUntil(createRoute(GeoLocationScreen.routeName), (route) => false);
                          }
                        }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }





  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.only(right: 10),
      height: 6,
      width: currentPage == index ? 50 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.black : Colors.grey,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

