import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/screens/login.dart';
import 'package:test/screens/first_run.dart';
import '../models/user.dart';

class UserRegist extends StatefulWidget {
  User user;
  
  UserRegist(this.user, {super.key});

  @override
  State<UserRegist> createState() => _UserRegist();
}

class _UserRegist extends State<UserRegist> {

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
                    controller: widget.user.id,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    validator: (value) { return widget.user.idCheck(value);},
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
                    controller: widget.user.pw,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    validator: (value) { 
                      pwCheck = value == null ? '' : value.toString();
                      return widget.user.pwCheck(value);
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
                    validator: (value) { return widget.user.pwEqualCheck(value, pwCheck);},
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
                    controller: widget.user.email,
                    textInputAction: TextInputAction.next,
                    validator: (value) { return widget.user.emailCheck(value);},
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
                    controller: widget.user.phoneNumber,
                    validator: (value) { return widget.user.phoneNumberCheck(value);},
                  ),
                  SizedBox(
                    height: 20,
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
                        widget.user.Regist().then((String result) {
                          if (result == "0") {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FirstRun()),);
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
                                    children: <Widget>[Text("이미 사용중인 아이디입니다.",),],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('확인'), 
                                      onPressed: () {
                                        Navigator.pop(context);
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
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}