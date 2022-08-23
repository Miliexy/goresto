
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goresto/Screens/Restaurant/restaurant_screen.dart';
import 'package:goresto/routes.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.radius,
    required this.height,
    required this.width,
    required this.index,
    required this.info,
  }) : super(key: key);

  final Radius radius;
  final double height;
  final double width;
  final int index;
  final Map<String, String> info;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
              onTap: () => Navigator.of(context).push(createRoute(RestaurantScreen.routeName)),
              child: Container(
                clipBehavior: Clip.hardEdge,
                width: constraints.maxWidth * 0.9,
                height: height * 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(radius),
                    border: Border.all(color: Colors.black, width: 0.5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0.5, 0))
                    ]),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(info["image"].toString()),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Expanded(
                          flex: 2,

                          child: Container(
                            color: Color(0xae1c1b1b),

                          ),
                        )
                      ],
                    ),
                    if (constraints.maxHeight < 300.0)
                      Positioned(
                        left: constraints.biggest.width * 0.08,
                        top: constraints.biggest.height * 0.52,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 23,
                              backgroundImage:
                                  AssetImage(info["image"].toString()),
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.03,
                            ),
                            const Text(
                              "Restaurant",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.03,
                            ),
                            Text("descirption", style: GoogleFonts.montserratAlternates(color: Colors.white),)
                          ],
                        ),
                      ),
                    Positioned(
                      left: constraints.biggest.width * 0.55,
                      top: constraints.biggest.height * 0.65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.whatsapp, color: Colors.white,),
                            onPressed: () async {

                              var whatsapp = "212663845706";
                              var whatsappURlAndroid ="whatsapp://send?phone=$whatsapp?text=${Uri.parse("hello")}";
                                  "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
                                  var uri = Uri.parse('whatsapp://send?phone=$whatsapp&text=${Uri.parse("hello")}');

                              // android , web
                              if (await canLaunchUrlString(whatsappURlAndroid)) {
                                await launchUrlString(whatsappURlAndroid);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration: const Duration(
                                            seconds: 2, milliseconds: 500),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        width: width * 80,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.white,
                                        content: const Text(
                                          "Whatsapp is not installed",
                                          style: TextStyle(color: Colors.black),
                                        )));
                              }
                            },
                            iconSize: 30,
                          ),
                          SizedBox(
                            width: width * 3,
                          ),
                          IconButton(
                            icon: const Icon(Icons.location_on_outlined, color: Colors.white,),
                            onPressed: () {},
                            iconSize: 30,
                          )
                        ],
                      ),
                    ),
                    if (constraints.maxHeight > 300.0)
                      Positioned(
                        left: constraints.biggest.width * 0.08,
                        top: constraints.biggest.height * 0.56,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 45,
                              backgroundImage:
                                  AssetImage(info["image"].toString()),
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.03,
                            ),
                            Row(
                              children: const [
                                Text(
                                  "Restaurant's name",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              ],
                            )
                          ],
                        ),
                      ) //Wide,Tablet screens
                  ],
                ),
              ),
            ));
  }
}
