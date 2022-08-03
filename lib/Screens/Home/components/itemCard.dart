import 'dart:io';

import 'package:flutter/material.dart';
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
              onTap: () => Navigator.of(context).push(createRoute()),
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
                          offset: Offset(0.5, 0))
                    ]),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(info["image"].toString()),
                                    fit: BoxFit.cover)),
                          ),
                          flex: 3,
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.grey,
                          ),
                          flex: 2,
                        )
                      ],
                    ),
                    if (constraints.maxHeight < 300.0)
                      Positioned(
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
                            Text(
                              "Restaurant",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.03,
                            ),
                            Text("descirption")
                          ],
                        ),
                        left: constraints.biggest.width * 0.08,
                        top: constraints.biggest.height * 0.52,
                      ),
                    Positioned(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.whatsapp),
                            onPressed: () async {
                              var whatsapp = "+919144040888";
                              var whatsappURl_android =
                                  "whatsapp://send?phone=" +
                                      whatsapp +
                                      "&text=hello";
                              var whatappURL_ios =
                                  "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";

                              // android , web
                              if (await canLaunchUrlString(
                                  whatsappURl_android)) {
                                await launchUrlString(whatsappURl_android);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(
                                      duration: Duration(seconds: 2, milliseconds: 500),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                        width: width * 80,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.white,
                                        content:
                                            Text("Whatsapp is not installed", style: TextStyle(color: Colors.black),)));
                              }
                            },
                            iconSize: 30,
                          ),
                          SizedBox(
                            width: width * 3,
                          ),
                          IconButton(
                            icon: Icon(Icons.location_on_outlined),
                            onPressed: () {},
                            iconSize: 30,
                          )
                        ],
                      ),
                      left: constraints.biggest.width * 0.55,
                      top: constraints.biggest.height * 0.65,
                    ),
                    if (constraints.maxHeight > 300.0)
                      Positioned(
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
                              children: [
                                Text(
                                  "Restaurant's name",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 25),
                                ),
                              ],
                            )
                          ],
                        ),
                        left: constraints.biggest.width * 0.08,
                        top: constraints.biggest.height * 0.56,
                      ) //Wide,Tablet screens
                  ],
                ),
              ),
            ));
  }
}
