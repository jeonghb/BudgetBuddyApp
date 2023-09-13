import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/app_core.dart';
import 'package:test/screens/first_run.dart';
import 'package:test/widgets/text_form_field_v1.dart';
import 'package:test/widgets/top_bar.dart';
import '../../models/user.dart';
import '../../widgets/title_text.dart';

class UserRegist extends StatefulWidget {
  final User user;
  
  UserRegist({super.key, required this.user});

  @override
  State<UserRegist> createState() => _UserRegist();
}

class _UserRegist extends State<UserRegist> {

  String validationCheck() {
    if (!widget.user.idRegexCheck()) {
      return '아이디를 확인해주세요.';
    }
    else if (!widget.user.passwordRegexCheck()) {
      return '비밀번호를 확인해주세요';
    }
    else if (!widget.user.passwordSameCheck()) {
      return '비밀번호를 확인해주세요.';
    }
    else if (!widget.user.emailRegexCheck()) {
      return '이메일을 확인해주세요.';
    }
    else if (!widget.user.phoneNumberRegexCheck()) {
      return '휴대폰번호를 확인해주세요.';
    }

    return '';
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
                  TitleText(
                    text: '회원가입',
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
                      return widget.user.passwordCheck();
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
                    validator: (value) { return widget.user.passwordEqualCheck();},
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
                        String validationMessage = validationCheck();
                        if (validationMessage.isNotEmpty) {
                          AppCore.showMessage(context, '회원가입', validationMessage, ActionType.ok, () {
                            Navigator.pop(context);
                          });
                          return;
                        }
                        widget.user.userRegist().then((String result) {
                          if (result == "0") {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FirstRun()),);
                          }
                          else if (result == "1") {
                            AppCore.showMessage(context, '회원가입', '이미 사용중인 아이디입니다.', ActionType.ok, () {
                              Navigator.pop(context);
                            });
                          }
                          else {
                            AppCore.showMessage(context, '회원가입', '가입정보를 확인 중 오류가 발생하였습니다. 다시 시도해주세요.', ActionType.ok, () {
                              Navigator.pop(context);
                            });
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