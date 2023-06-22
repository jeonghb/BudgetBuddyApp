import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/screens/first_run.dart';
import 'package:test/widgets/text_form_field_v1.dart';
import 'package:test/widgets/top_bar.dart';
import '../models/user.dart';

class UserRegist extends StatefulWidget {
  final User user;
  
  UserRegist({super.key, required this.user});

  @override
  State<UserRegist> createState() => _UserRegist();
}

class _UserRegist extends State<UserRegist> {

  bool validationCheck() {
    if (!widget.user.idRegexCheck() || !widget.user.passwordRegexCheck() || !widget.user.passwordSameCheck() || !widget.user.emailRegexCheck() || !widget.user.phoneNumberRegexCheck()) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => { FocusScope.of(context).unfocus()},
      child: Scaffold(
        appBar: TopBar(type: BarType.logout),
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
                  Text('회원가입',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('아이디',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldV1(
                    hintText: 'ID',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.name,
                    controller: widget.user.userId,
                    textInputAction: TextInputAction.next,
                    validator: (value) { return widget.user.idCheck();},
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('비밀번호',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldV1(
                    hintText: '●●●●●●●●',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.visiblePassword,
                    controller: widget.user.userPassword,
                    textInputAction: TextInputAction.next,
                    validator: (value) { 
                      return widget.user.pwCheck();
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('비밀번호 확인',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldV1(
                    hintText: '●●●●●●●●',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    validator: (value) { return widget.user.pwEqualCheck();},
                    controller: widget.user.userPasswordCheck,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('이메일',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldV1(
                    hintText: 'honggildong@gmail.com',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.emailAddress,
                    controller: widget.user.userEmail,
                    textInputAction: TextInputAction.next,
                    validator: (value) { return widget.user.emailCheck();},
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('휴대폰번호',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldV1(
                    hintText: '(-)없이 입력. ex)01012345678',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.phone,
                    controller: widget.user.userPhoneNumber,
                    textInputAction: TextInputAction.done,
                    validator: (value) { return widget.user.phoneNumberCheck();},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(120),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 90, 68, 223),
                      ),
                      child: Text('가입하기',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                      ),),
                      onPressed: () {
                        if (!validationCheck()) {
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                title: Column(children: const <Widget>[Text('회원가입')]),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const <Widget>[Text("정상적으로 입력되지 않은 항목이 있습니다. 확인 후 다시 시도해주세요.",),],
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
                          return;
                        }
                        widget.user.userRegist().then((String result) {
                          if (result == "0") {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FirstRun()),);
                          }
                          else if (result == "1") {
                            showDialog(
                              context: context, 
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  title: Column(children: const <Widget>[Text('회원가입')]),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const <Widget>[Text("이미 사용중인 아이디입니다.",),],
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
                                  title: Column(children: const <Widget>[Text('회원가입')]),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const <Widget>[Text("가입정보를 확인 중 오류가 발생하였습니다. 다시 시도해주세요.",),],
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