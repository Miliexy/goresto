import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class GetLocation {
  Position? _position;
  List<Placemark>? _placeMarks;
  LocationPermission? _permission;

  Future<List<Placemark>> getCurrentLocation() async {
    Position position = await _determinePosition();
    List<Placemark> placeMarks = await  _decodingLocation(position);
    return placeMarks;
  }

  Future<List<Location>> getCoordinates(String address) async {
    List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
    return locations;
  }

  Future<LocationPermission> fetchPermissions() async{

    _permission = await Geolocator.checkPermission();

    if(_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if(_permission == LocationPermission.deniedForever) {
        return Future.error("Permissions to access location data were denied forever, please change that in the settings");
      }
    }
    return  _permission! ;
  }
  Future<Position> _determinePosition() async {
    if(_permission == LocationPermission.denied) return Future.error('Please enable location permissions');
    return await Geolocator.getCurrentPosition();
  }
  Future<List<Placemark>> _decodingLocation(Position position) async {
    return await placemarkFromCoordinates(position.latitude, position.longitude);
  }
}

class CurrentLocation extends StatefulWidget {
  static var routeName = "/location";

  const CurrentLocation({Key? key}) : super(key: key);

  @override
  State<CurrentLocation> createState() => _CurrentLocationState ();
}

class _CurrentLocationState extends State<CurrentLocation>  {
  Position? _position;
  List<Placemark>? _placeMarks;

  void _getCurrentAddress(Position position) async {
    List<Placemark> placemarks = await  placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _placeMarks = placemarks;
    });
  }

  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    List<Placemark> placemarks = await  _decodingLocation(position);
    setState(() {
      _position = position;
      _placeMarks = placemarks;
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }
    return await Geolocator.getCurrentPosition();
  }
  Future<List<Placemark>> _decodingLocation(Position position) async {
    return await placemarkFromCoordinates(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Icon(Icons.add_location),
            ),
            _placeMarks != null ? Text(_placeMarks![0].street.toString(), style: const TextStyle(fontSize: 10),) : const Text("No location data")
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }

}
