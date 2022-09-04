import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static String routeName = "/search";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {},
          ),
        ],

        title: TextField(
          autofocus: true,
          decoration: InputDecoration(
              hintText: "search",
              border: InputBorder.none,
              ),
        ),
      ),
      body: Container(color: Colors.red,),
    );
  }
}
