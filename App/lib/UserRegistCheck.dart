import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/class/User.dart';
import 'package:test/UserRegist.dart';
import 'LogIn.dart';

User user = User();

class UserRegistCheck extends StatefulWidget {
  const UserRegistCheck({super.key});

  @override
  State<UserRegistCheck> createState() => _UserRegistCheck();
}

class _UserRegistCheck extends State<UserRegistCheck> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => { FocusScope.of(context).unfocus()},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('SANDOL',
            style: TextStyle(
              color: Color.fromARGB(255, 90, 68, 223),
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('회원가입',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('이름',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red)
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    autofocus: true,
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.name,
                    controller: user.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) { return user.nameCheck(value);},
                  ),
                  SizedBox(
                    height: 20,
                  ),
                       Text('생년월일',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(01)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red)
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    autofocus: true,
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.number,
                    // controller: user.birthDay,
                    textInputAction: TextInputAction.next,
                    // validator: (value) { return user.nameCheck(value);},
                  ),

                  Row(
                    children: <Widget>[
                      BirthdaySelectWidget(),
                      SizedBox(width: 30),
                      SexSelectWidget(sex: 'male'),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(120),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: Text('다음',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),),
                      onPressed: () {
                        user.birthDay.text = birthday;
                        user.Check().then((String result) {
                          if (result == "0") {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegist(user)),);
                          }
                          else if (result == "1") {
                            showDialog(
                              context: context, 
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  title: Column(children: <Widget>[Text('회원가입')]),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[Text("이미 가입된 정보가 있습니다. 로그인 화면으로 이동합니다.",),],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('확인'), 
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()),);
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          }
                          else {
                            showDialog(
                              context: context, 
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  title: Column(children: <Widget>[Text('회원가입')]),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[Text("가입정보를 확인 중 오류가 발생하였습니다. 다시 시도해주세요.",),],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('확인'), 
                                      onPressed: () {Navigator.pop(context);},
                                    )
                                  ],
                                );
                              }
                            );
                          }
                        });
                      },
                    ),
                  ),
                ]
              )
            )
          )
        )
      )
    );
  }
}

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
                      onDateTimeChanged: (DateTime newDate) {setState(() => date = newDate); birthday = date.toString();},
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: date,
                      maximumDate: DateTime.now(),
                      
                    ),
                  );
                  // birthday = '${date.year}-${date.month}-${date.day}';
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

String sex = "male";

class SexSelectWidget extends StatefulWidget {
  SexSelectWidget({super.key, @required sex});

  @override
  State<SexSelectWidget> createState() => _SexSelectWidget();
}

class _SexSelectWidget extends State<SexSelectWidget> {
  DateTime date = DateTime.now();
  bool male = true;
  bool famale = false;
  Color birthDay = Color.fromARGB(255, 197, 197, 197);
  late List<bool> isSelected = [male, famale];

  @override
  Widget build(BuildContext context) {
    
    user.sex.text = sex;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Expanded(
        child: ToggleButtons(
          isSelected: isSelected,
          children: [
            Padding(padding: EdgeInsets.all(10), child: Text('남'),),
            Padding(padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(60)), child: Text('여'),)
          ],

          onPressed: toggleSelect,
        ),
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