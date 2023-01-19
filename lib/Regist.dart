import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/main.dart';
import 'RegistStatus.dart';

class RegistPage extends StatefulWidget {
  const RegistPage({super.key});

  @override
  State<RegistPage> createState() => _RegistPageState();
}
    
RegistStatus registStatus = RegistStatus();

class _RegistPageState extends State<RegistPage> {

  @override
  Widget build(BuildContext context) {
    
    String pwCheck = '';

    return GestureDetector(
      onTap: () => { FocusScope.of(context).unfocus()},
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.fromLTRB(30, 100, 30, 100),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: '아이디',
                      hintText: 'ID',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 223, 219, 215))
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 219, 215),
                      labelStyle: TextStyle(
                        fontSize: 35
                      ),
                    ),
                    autofocus: true,
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.name,
                    controller: registStatus.id,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    validator: (value) { return ValidationCheck.idCheck(value);},
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: '비밀번호',
                      hintText: '●●●●●●●●',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 223, 219, 215))
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 219, 215),
                      labelStyle: TextStyle(
                        fontSize: 35
                      ),
                    ),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.visiblePassword,
                    controller: registStatus.pw,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    validator: (value) { 
                      pwCheck = value == null ? '' : value.toString();
                      return ValidationCheck.pwCheck(value);
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: '비밀번호 확인',
                      hintText: '●●●●●●●●',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 223, 219, 215))
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 219, 215),
                      labelStyle: TextStyle(
                        fontSize: 35
                      ),
                    ),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    validator: (value) { return ValidationCheck.pwEqualCheck(value, pwCheck);},
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: '이름',
                      hintText: '홍길동',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 223, 219, 215))
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 219, 215),
                      labelStyle: TextStyle(
                        fontSize: 35
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.name,
                    controller: registStatus.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) { return ValidationCheck.nameCheck(value);},
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: '이메일',
                      hintText: 'honggildong@gmail.com',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 223, 219, 215))
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 219, 215),
                      labelStyle: TextStyle(
                        fontSize: 35
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.emailAddress,
                    controller: registStatus.email,
                    textInputAction: TextInputAction.next,
                    validator: (value) { return ValidationCheck.emailCheck(value);},
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: '휴대폰번호',
                      hintText: '(-)없이 입력. ex)01012345678',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 223, 219, 215))
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 219, 215),
                      labelStyle: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.phone,
                    controller: registStatus.phoneNumber,
                    validator: (value) { return ValidationCheck.phoneNumberCheck(value);},
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CheckSexWidget(
                    
                  ),
                  Text(''),
                  SizedBox(
                    // height: 80,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(120),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 190, 180, 170),
                      ),
                      child: Text('가입 신청',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black
                      ),),
                      onPressed: () {
                        registStatus.Regist();
                        // if (registStatus.Regist() == true) {
                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()),);
                        // }
                      },
                    ),
                  ),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}

class CheckSexWidget extends StatefulWidget {
  CheckSexWidget({super.key});

  late ValueChanged<DateTime> birthDay;

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
                    color: birthDay
                  ),
                ),
                onPressed: () => _showDialog(
                  CupertinoDatePicker(
                    onDateTimeChanged: (DateTime newDate) {setState(() => date = newDate);},
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: date,
                    maximumDate: DateTime.now(),
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

class ValidationCheck{
  static RegExp idRegExp = RegExp(r'[\W]|[\\\[\]\^\`]');
  static RegExp pwRegExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}');
  static RegExp nameRegExp = RegExp(r'[가-힣]');
  static RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  static RegExp phoneNumberRegExp = RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$');

  static String? idCheck(String? value) {
    return value == null || value.length < 5 || idRegExp.hasMatch(value) ? '5자 이상이어야 하며, 특수문자는 _만 사용 가능합니다.' : null;
  }

  static String? pwCheck(String? value) {
    return value == null || !pwRegExp.hasMatch(value) ? '알파벳 대문자, 소문자, 숫자, 특수문자를 반드시 포함하여 8자 이상 입력하세요.' : null;
  }

  static String? pwEqualCheck(String? value, String pwCheck) {
    return pwCheck == '' ? '비밀번호를 입력해주세요.' : (value == null ? '' : value.toString()) != pwCheck ? '입력한 비밀번호와 일치하지 않습니다.' : null;
  }

  static String? nameCheck(String? value) {
    return value == null || value.length < 2 || !nameRegExp.hasMatch(value) ? '정상적인 이름 형식이 아닙니다.' : null;
  }

  static String? emailCheck(String? value) {
    return value == null || !emailRegExp.hasMatch(value) ? '정상적인 이메일 형식이 아닙니다.' : null;
  }

  static String? phoneNumberCheck(String? value) {
    return value == null || !phoneNumberRegExp.hasMatch(value) ? '정상적인 휴대폰번호 형식이 아닙니다.' : null;
  }
}