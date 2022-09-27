
import 'package:flutter/material.dart';
import 'package:goresto/Screens/design_course/category.dart';
import 'package:goresto/Screens/testData/dataList.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/size_config.dart';

import 'buttonUi.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  get categoryType => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3, left: SizeConfig.blockSizeVertical * 2),
          child: Text(
            'Category',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig.blockSizeVertical * 2.5,
              letterSpacing: 0.27,
              color: kPrimaryLightColor,
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3,
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 6,
          child: Padding(
            padding: EdgeInsets.only(left: SizeConfig.blockSizeVertical * 2, right: SizeConfig.blockSizeVertical * 2),
            child: ListView.separated(
              separatorBuilder: (context, index) => VerticalDivider(color: Colors.transparent),
              shrinkWrap: true,
              itemCount: citiesList.values.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ButtonUi(data: categoriesList[index]);
              },
            ),
          ),
        ),
         SizedBox(
          height: SizeConfig.blockSizeVertical * 2.5,
        ),
        Padding(
          padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3, left: SizeConfig.blockSizeVertical * 2),
          child: Text(
            'Nos Recommendations',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig.blockSizeVertical * 2.5,
              letterSpacing: 0.27,
              color: kPrimaryLightColor,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        CategoryListView(
        ),
      ],
    );
  }
}

extension ParseToString on citiesList {
  String toShortString() {
    return this.toString().split('.').last;
  }
}