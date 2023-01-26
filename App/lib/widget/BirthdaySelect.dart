import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BirthdaySelectWidget extends StatefulWidget {
  BirthdaySelectWidget({super.key});

  late ValueChanged<DateTime> birthDay;

  @override
  State<BirthdaySelectWidget> createState() => _BirthdaySelectWidget();
}

String birthday = '';

class _BirthdaySelectWidget extends State<BirthdaySelectWidget> {

  DateTime date = DateTime.now();
  bool male = true;
  bool famale = false;
  Color birthDay = Color.fromARGB(255, 197, 197, 197);
  late List<bool> isSelected = [male, famale];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(100),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Row(children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                height: ScreenUtil().setHeight(100),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.grey))
                ),
                child: Center(
                  child: Text('생년월일',
                    style: TextStyle(
                      fontSize: 15,
                    ),)
                  ),
              ),
              CupertinoButton(
                child: Text('${date.year}-${date.month}-${date.day}',
                  style: TextStyle(
                    color: Colors.blue
                  ),
                ),
                onPressed: () {
                  _showDialog(
                    CupertinoDatePicker(
                      onDateTimeChanged: (DateTime newDate) {setState(() => date = newDate);},
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: date,
                      maximumDate: DateTime.now(),
                    ),
                  );
                  birthday = '${date.year}-${date.month}-${date.day}';
                }
              ),
            ],)
          ),
        ],
      ),
    );
  }
  
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: ScreenUtil().setHeight(360),
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}