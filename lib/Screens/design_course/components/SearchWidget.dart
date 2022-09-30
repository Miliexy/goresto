


import 'package:flutter/material.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/routes.dart';
import 'package:goresto/size_config.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    Key? key,
    required this.callBack,
  }) : super(key: key);
  final Function callBack;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(13.0),
          bottomLeft: Radius.circular(13.0),
          topLeft: Radius.circular(13.0),
          topRight: Radius.circular(13.0),
        ),
      ),
      height: SizeConfig.blockSizeVertical * 6,
      constraints:
      BoxConstraints(maxWidth: SizeConfig.blockSizeHorizontal * 89),
      child: TextFormField(
        maxLines: 1,
        expands: false,
        style: TextStyle(
          fontFamily: 'WorkSans',
          fontWeight: FontWeight.bold,
          fontSize: SizeConfig.blockSizeVertical * 2,
          color: kSecondaryColor,
        ),
        keyboardType: TextInputType.text,
        readOnly: true,
        showCursor: true,
        onTap: () {
          Navigator.pushNamed(context, AppRouter.searchRoute);
        },
        decoration: InputDecoration(
            hintText: "search",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            prefixIcon: Icon(
              Icons.search,
              size: SizeConfig.blockSizeVertical * 3,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.my_location,
                size: fontTextSize,
              ),
              onPressed: () {},
            )),
        onEditingComplete: () {},
      ),
    );
  }
}