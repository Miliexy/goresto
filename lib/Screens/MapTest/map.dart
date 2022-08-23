import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goresto/Services/location.dart';
import 'package:goresto/size_config.dart';

class MapTest extends StatefulWidget {
  const MapTest({Key? key}) : super(key: key);
  static String routeName = "/map";
  @override
  State<MapTest> createState() => _MapTestState();
}

class _MapTestState extends State<MapTest> {
  final _location = GetLocation();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map inside ListView')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 80,
              height: SizeConfig.blockSizeVertical * 50,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(52.2165157, 6.9437819), zoom: 14.5),
                markers: {
                  Marker(
                      markerId: MarkerId("source"),
                      position: LatLng(52.2165157, 6.9437819),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueYellow)),
                },
              ),
            ),

            const Card(
              child: ListTile(
                  title: Text(
                      'Scrolling inside the map does not scroll the ListView')),
            ),
            const SizedBox(height: 500),
            const Card(child: ListTile(title: Text('look at that scrolling')))
          ],
        ),
      ),
    );
  }
}
