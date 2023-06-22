// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/screens/login.dart';

import '../models/response_data.dart';
import '../models/user.dart';
import '../widgets/text_form_field_v1.dart';
import '../widgets/top_bar.dart';

class UpdatePassword extends StatefulWidget {
  final User user;

  const UpdatePassword({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => _UpdatePassword();
}

class _UpdatePassword extends State<UpdatePassword> {

  bool validationCheck() {
    if (!widget.user.passwordRegexCheck() || !widget.user.passwordSameCheck()) {
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
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('비밀번호 변경',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                  SizedBox(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(120),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: Text('변경',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (!validationCheck()) {
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                title: Text('비밀번호 변경'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const <Widget>[Text('정상적으로 입력되지 않은 항목이 있습니다. 확인 후 다시 시도해주세요.',),],
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

                        ResponseData responseData = await widget.user.userUpdatePassword();
                        if (responseData.statusCode == 200 && responseData.body.isEmpty) {
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                title: Text('비밀번호 변경'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const <Widget>[Text('일치하는 정보가 없습니다.',),],
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
                        else if (responseData.statusCode == 200 && widget.user.userId.text.isNotEmpty) {
                          await showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                title: Text('비밀번호 변경'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const <Widget>[Text("비밀번호 변경이 완료되었습니다. 로그인 화면으로 이동합니다.",),],
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
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()));
                        }
                        else {
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                title: Text('비밀번호 변경'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const <Widget>[Text("비밀번호를 변경하는 중 오류가 발생하였습니다. 다시 시도해주세요.",),],
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