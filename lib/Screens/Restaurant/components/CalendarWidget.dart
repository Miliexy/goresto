import 'package:flutter/material.dart';


class TimeTableWidget extends StatelessWidget {
  const TimeTableWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(horizontal: 12),
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        title: Text("Horaire"),
        leading: Icon(Icons.alarm),
        children: [
          ListTile(
            leading: Text("Lundi"),
            trailing: Text("Open 24h"),
          ),
          ListTile(
            leading: Text("Lundi"),
            trailing: Text("Open 24h"),
          ),
          ListTile(
            leading: Text("Lundi"),
            trailing: Text("Open 24h"),
          ),
          ListTile(
            leading: Text("Lundi"),
            trailing: Text("Open 24h"),
          )
        ],
      ),
    );
  }
}
