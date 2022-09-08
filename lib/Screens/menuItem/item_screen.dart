import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goresto/Screens/components/commentSection.dart';
import 'package:goresto/size_config.dart';

class MenuProduct extends StatefulWidget {
  const MenuProduct({Key? key, required List<dynamic> data}) : super(key: key);
  static String routeName ="/item";

  @override
  State<MenuProduct> createState() => _MenuProductState();
}

class _MenuProductState extends State<MenuProduct> {
  int _value = 1;
  late bool _isButtonDisabled ;
  late ScrollController _controller;
  bool popFlag = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    _isButtonDisabled = false;
  }

  _scrollListener() {
    if (_controller.offset <= _controller.position.minScrollExtent &&
        popFlag == false) {
      popFlag = true;
      Navigator.of(context).pop();
    }
  }

  void _incrementValue(){
   setState(() {
     _isButtonDisabled = false;
     _value++;
   });
  }
  void _decrementValue(){
    setState(() {
      if(_value == 1) {
        _isButtonDisabled = true;
        _value--;
        return ;
      }
      if(_value > 1 ) _value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'containerHero',
              child: Column(
                children: [
                  Image.asset("assets/images/fine-dining1.jpg"),
                  Text("Item Name"),
                  Row(
                    children: [
                      Text(
                        "12.55",
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough),
                      ),
                      Text("10.55"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: _isButtonDisabled ? null : _decrementValue, icon: Icon(Icons.remove),),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 13,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: TextEditingController(
                            text: '$_value',
                          ),
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                        ),
                      ),
                      IconButton(onPressed: _incrementValue, icon: Icon(Icons.add)),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {}, child: Text("Add to cart"))
                ],
              ),
            ),
            CommentSection(testText: "testText")
          ],
        ),
      ),
    );
  }
}
