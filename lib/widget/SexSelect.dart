import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SexSelectWidget extends StatefulWidget {
  SexSelectWidget({super.key, @required sex});

  @override
  State<SexSelectWidget> createState() => _SexSelectWidget();
}

String sex = 'male';

class _SexSelectWidget extends State<SexSelectWidget> {
  DateTime date = DateTime.now();
  bool male = true;
  bool famale = false;
  Color birthDay = Color.fromARGB(255, 197, 197, 197);
  late List<bool> isSelected = [male, famale];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ToggleButtons(
        isSelected: isSelected,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(60)), child: Text('남'),),
          Padding(padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(60)), child: Text('여'),)
        ],

        onPressed: toggleSelect,
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

  void toggleSelect(value){
    if (value == 0){
      sex = 'male';
      male = true;
      famale = false;
    }
    else{
      sex = 'female';
      male = false;
      famale = true;
    }

    setState(() =>{
      isSelected = [male, famale]
    });
  }
}