import 'package:flutter/material.dart';
import 'package:goresto/Screens/Home/home_screen.dart';
import 'package:goresto/Screens/components/default_button.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/routes.dart';
import 'package:goresto/size_config.dart';
import 'package:location/location.dart';

import 'welcome_content.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> welcomeData = [
    {"text": "hello world 1", "image": "assets/images/image.webp"},
    {"text": "hello world 2", "image": "assets/images/placeholder.png"},
    {"text": "hello world 3", "image": "assets/images/pngegg.png"},
  ];

  late PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: SizeConfig.blockSizeVertical * 80,
        width: double.infinity,
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: Row(
                    children: <Widget>[
                      Expanded(child: TextButton(
                        onPressed: (){
                          //open camera and take picture and save it to storage
                        },
                        child: Text("skip", style: TextStyle(color: kPrimaryColor)),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(CircleBorder()),
                          backgroundColor: MaterialStateProperty.all(Colors.transparent)
                        )
                      ),),

                      Expanded(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            welcomeData.length, (index) => buildDot(index: index)),
                      ),),
                      Expanded(child: DefaultButton(text: "text", icon: Icon(Icons.arrow_forward_sharp),press: () {
                        _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                        //redirect to home screen if last page
                        if(currentPage == welcomeData.length - 1){
                          Navigator.of(context).push(createRoute());
                        }
                      }),),
                    ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 10),
      height: 6,
      width: currentPage == index ? 50 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xADFFECCC),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

