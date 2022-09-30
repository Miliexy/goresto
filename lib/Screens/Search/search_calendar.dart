import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goresto/Screens/Search/components/searchBarUi.dart';
import 'package:intl/intl.dart';

import '../../constansts.dart';
import '../../size_config.dart';
import 'CityFilterScreen.dart';

class SearchCalendar extends StatefulWidget {
  const SearchCalendar({Key? key}) : super(key: key);

  @override
  State<SearchCalendar> createState() => _SearchCalendarState();
}

class _SearchCalendarState extends State<SearchCalendar> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool isSwitched = false;
  TextEditingController _timeController = TextEditingController();
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay =
        await showTimePicker(context: context, initialTime: _selectedTime,
        builder: (context, child) {
          return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child ?? SizedBox()  ,);
        },);
    if(timeOfDay != null){
      setState(() {
        _selectedTime = timeOfDay;
        _timeController.text = DateFormat("HH:mm").format(DateTime(2019, 08, 1, _selectedTime.hour, _selectedTime.minute));

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarColor: Colors.transparent,
                statusBarColor: Colors.transparent
            )
        ),
        preferredSize: Size.zero,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SearchBarUI(hintText: "Quand ?", enabled: false),
              CalendarDatePicker(
                onDateChanged: (value) {},
                firstDate: DateTime.now(),
                initialDate: DateTime.now(),
                lastDate: DateTime(3000),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Chosir l'heure"),
                      Visibility(child: InkWell(child: Text(_timeController.text), onTap: (){
                        _selectTime(context);
                      },), visible: isSwitched),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                          if (isSwitched) {
                            _selectTime(context);
                          }
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          NextButtonWidget()
        ],
      ),
    );
  }
}

class NextButtonWidget extends StatelessWidget {
  const NextButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(bottom: SizeConfig.blockSizeVertical * 5,
      right: SizeConfig.blockSizeHorizontal * 5,child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
            fixedSize: MaterialStateProperty.all(Size(SizeConfig.blockSizeHorizontal * 40, SizeConfig.blockSizeVertical * 5))
        ),
        child: Text("Suivant", style: Theme.of(context).primaryTextTheme.titleMedium,),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CityFilterScreen(),));
        },
      ),
    );
  }
}
