import 'package:flutter/material.dart';
import 'package:goresto/size_config.dart';

class MenuList extends StatefulWidget {
  const MenuList({Key? key}) : super(key: key);

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(height: SizeConfig.blockSizeVertical * 0.2,);
        },
        shrinkWrap: true,
        padding: EdgeInsets.only(top:SizeConfig.blockSizeVertical * 2, left: SizeConfig.blockSizeHorizontal * 3, right: SizeConfig.blockSizeHorizontal * 3),
        physics: NeverScrollableScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        controller: _scrollController,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Navigator.of(context).pushNamed("/item", arguments: []);
            },
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                      height: SizeConfig.blockSizeVertical *10,
                      width: SizeConfig.blockSizeHorizontal* 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                      ),
                      child: Image.asset("assets/images/fine-dining1.jpg")
                  ),
                  Expanded(
                    child: Padding(
                      padding:  EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2, left: SizeConfig.blockSizeHorizontal * 2, right: SizeConfig.blockSizeHorizontal *2),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Item Name", style: Theme.of(context).textTheme.titleMedium,),
                              Text("35.00 MAD")
                            ],
                          ),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: 10,
      ),
    );

  }
}
