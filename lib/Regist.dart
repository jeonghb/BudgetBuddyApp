// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistPage extends StatelessWidget {
  const RegistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 237, 233),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(30, 100, 30, 100),
          child: Center(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'ID',
                  labelStyle: TextStyle(
                    fontSize: 25
                  )),
                ),
                Text(''),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password',
                  labelStyle: TextStyle(
                    fontSize: 25
                  )),
                ),
                Text(''),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name',
                  labelStyle: TextStyle(
                    fontSize: 25
                  )),
                ),
                Text(''),
                SizedBox(
                  height: 20,
                ),
                CheckSexWidget(),
                Text(''),
                SizedBox(
                  // height: 80,
                ),
                ElvbNewRegist(),
              ],
            )
          ),
        ),
      )
    );
  }
}

class CheckSexWidget extends StatefulWidget {
  const CheckSexWidget({super.key});

  @override
  State<CheckSexWidget> createState() => _CheckSexWidgetState();
}

class _CheckSexWidgetState extends State<CheckSexWidget> {

  DateTime date = DateTime.now();
  bool male = true;
  bool famale = false;
  Color birthDay = Color.fromARGB(255, 197, 197, 197);
  late List<bool> isSelected = [male, famale];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
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
                    color: birthDay
                  ),),
                  onPressed: () => _showDialog(
                    CupertinoDatePicker(
                      onDateTimeChanged: (DateTime newDate) {setState(() => date = newDate);},
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: date,
                      use24hFormat: false,
                    ),
                  ),
                ),
              ],)
            ),
            SizedBox(
              width: ScreenUtil().setWidth(50),
            ),
            ToggleButtons(
              isSelected: isSelected,
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(60)), child: Text('남'),),
                Padding(padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(60)), child: Text('여'),)
              ],
              onPressed: toggleSelect,
            ),
          ],
        ),
      )
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
            ));
  }

  void toggleSelect(value){
    if (value == 0){
      male = true;
      famale = false;
    }
    else{
      male = false;
      famale = true;
    }

    setState(() =>{
      isSelected = [male, famale]
    });
  }
}

class ElvbNewRegist extends StatefulWidget {
  const ElvbNewRegist({super.key});

  @override
  State<ElvbNewRegist> createState() => _ElvbNewRegist();
}

class _ElvbNewRegist extends State<ElvbNewRegist> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: ScreenUtil().setHeight(120),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 190, 180, 170),
          ),
          child: Text('가입',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black
          ),),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => RegistPage()),
            );
          },
        ),
      ),
    );
  }
}