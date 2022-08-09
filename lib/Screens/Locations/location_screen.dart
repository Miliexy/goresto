import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goresto/Screens/Home/home_screen.dart';
import 'package:goresto/Screens/components/animatedDialog.dart';
import 'package:goresto/Services/location.dart';
import 'package:goresto/routes.dart';
import 'package:goresto/size_config.dart';

class GeoLocationScreen extends StatefulWidget {
  static var routeName = "/location";
  const GeoLocationScreen({Key? key}) : super(key: key);

  @override
  State<GeoLocationScreen> createState() => _GeoLocationScreenState();
}

class _GeoLocationScreenState extends State<GeoLocationScreen> {
  var _location = GetLocation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: SizeConfig.blockSizeHorizontal * 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(child:Image.asset("assets/images/map_location.png")
                ),
                SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
                    child: Center(
                        child: Text(
                      "Allow your Location",
                      style: GoogleFonts.montserrat(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ))),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 60,
                  height: SizeConfig.blockSizeVertical * 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Text(
                        "We will need your location to give you better experience.",
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                        ),
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 70,
                  child: TextButton(
                    onPressed: ()  {
                      showDialog(context: context, builder: ((context) {

                        Future.delayed(Duration(seconds: 5), () {
                          Navigator.of(context).pop(true);
                        });
                        return Dialog(
                          child: SizedBox(
                            height: SizeConfig.blockSizeVertical * 20,
                            width: SizeConfig.blockSizeHorizontal * 20,
                            child: FutureBuilder<List<Placemark>>(
                            future: _location.getCurrentLocation(), // a previously-obtained Future<String> or null
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              List<Widget> children;
                              if (snapshot.hasData) {
                                children = <Widget>[
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                    size: 60,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Text('Results: ${snapshot.data[0].country}'),
                                  )
                                ];
                              } else if (snapshot.hasError) {
                                children = <Widget>[
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 60,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Text('Error: ${snapshot.error}'),
                                  )
                                ];
                              } else {
                                children = const <Widget>[
                                  SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: CircularProgressIndicator(),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: Text('Fetching Location'),
                                  )
                                ];
                              }
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: children,
                                ),
                              );
                            },
                        ),
                          ),);
                      })).then((value) => Future.delayed(Duration(seconds: 1 ),() => Navigator.of(context).pushAndRemoveUntil(createRoute(HomeScreen.routeName), (route) => false)));
                    },
                    child: Text("Sure, I'd like that",
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)))),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 70,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushAndRemoveUntil(createRoute(HomeScreen.routeName), (route) => false);
                    },
                    child: Text("Not now",
                        style: GoogleFonts.montserrat(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
