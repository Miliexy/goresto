import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goresto/Screens/testData/dataList.dart';
import 'package:goresto/Services/CustomInfoWindows.dart';
import 'package:goresto/Services/location.dart';
import 'package:goresto/size_config.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;

class MapTest extends StatefulWidget {
  final AnimationController animationController;

  const MapTest({Key? key, required this.animationController})
      : super(key: key);
  static String routeName = "/map";
  @override
  State<MapTest> createState() => _MapTestState();
}

class _MapTestState extends State<MapTest> {
  final _location = GetLocation();
  CustomInfoWindowController controller = CustomInfoWindowController();

  GoogleMapController? mapController; //contrller for Google map
  Set<Marker> markers = Set(); //markers for google map

  @override
  void dispose() {
    // TODO: implement dispose
    mapController!.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    addMarkers();
    super.initState();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width).then((value) {
          return Future.value();
    });
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  addMarkers() async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/restaurant_Avatar1.png', 200);
    final Uint8List markerIcon2 =
        await getBytesFromAsset('assets/images/restaurant_Avatar2.png', 100);

    markers.add(
      Marker(
        //add start location marker
        markerId: MarkerId(restaurantsList[0]["name"]),
        position: LatLng(52.2165157, 6.9437819), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: restaurantsList[0]["name"],
        ),
        icon: BitmapDescriptor.fromBytes(markerIcon), //Icon for Marker
      ),
    );
    markers.add(
      Marker(
        //add start location marker
        markerId: MarkerId(restaurantsList[0]["name"]),
        position: LatLng(52.2165160, 6.9437819), //position of marker
        onTap: () {

        },
        infoWindow: InfoWindow(onTap:() {
          controller.addInfoWindow!(
              Container(
                height: SizeConfig.blockSizeVertical * 20,
                width: SizeConfig.blockSizeHorizontal * 15,
                child: Stack(
                  children: [
                    Image.asset("assets/images/image.webp"),
                    Text("Hello world")
                  ],
                ),
              ),
              LatLng(52.2165160, 6.9437819));
        }, ),
        icon: BitmapDescriptor.fromBytes(markerIcon), //Icon for Marker
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mapIntroAnimation =
        Tween(begin: Offset(3, 0), end: Offset(0, 0)).animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.5,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: mapIntroAnimation,
      child: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: false,
            zoomGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: false,
            rotateGesturesEnabled: true,
            zoomControlsEnabled: false,
            onTap: (position) {
              controller.hideInfoWindow!();
            },
            onCameraMove: (position) {
              controller.onCameraMove!();
            },

            gestureRecognizers: Set()
              ..add(Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer())),
            initialCameraPosition:
                CameraPosition(target: LatLng(52.2165157, 6.9437819), zoom: 14.5),
            markers: markers,
            onMapCreated: (cont) => setState(() {
              mapController = cont;
              controller.googleMapController = cont;

            }),
          ),
          CustomInfoWindow((top, left, width, height) => null, controller: controller  ,),
        ],
      ),
    );
  }
}
