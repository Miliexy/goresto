import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;

class MapLocationWidget extends StatelessWidget {
  const MapLocationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(horizontal: 12),
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          const ListTile(
            leading: Icon(Icons.map),
            title: Text('Location'),
          ),
          Container(
              padding: EdgeInsets.all(20),
              width: SizeConfig.blockSizeHorizontal * 95,
              height: SizeConfig.blockSizeVertical * 40,
              child: FutureBuilder<http.Response>(
                future: fetchData(),
                builder: (context, snapshot) {
                  Widget child;
                  if(snapshot.hasData){
                    child = Stack(fit: StackFit.expand,
                      children: [
                      Ink(child: Image.memory(snapshot.data!.bodyBytes, fit: BoxFit.cover),),
                      Material(
                        child: InkWell(
                          onTap: (){},
                        ),
                        color: Colors.transparent,
                      )
                    ],);
                  }
                  else if(snapshot.hasError){
                    child = Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }else {
                    child= Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: CircularProgressIndicator(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Fetching Location'),
                        )
                      ],
                    );
                  }
                  return Container(
                    child: child
                  );
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Text("Address "),
            TextButton(onPressed: () {}, child: Text("Get Directions", style: TextStyle(color: kSecondaryColor, fontSize: fontTextSize, fontWeight: FontWeight.w600),), style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(Size(SizeConfig.blockSizeHorizontal * 40, SizeConfig.blockSizeVertical* 8)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
            ),
            )
          ],),
          SizedBox(height: SizeConfig.blockSizeVertical* 2,)
        ],
      ),
    );
  }

  Future<http.Response> fetchData() async {
    var response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/staticmap?&zoom=15&size=600x600&markers=size:mid|color:red|label:S|33.59289683131272, -7.6213941404167205&key=${FlutterConfig.get('GOOGLE_MAPS_API_KEY')}'));
    return response;
  }
}
