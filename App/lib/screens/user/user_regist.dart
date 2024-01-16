import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/app_core.dart';
import 'package:test/screens/login.dart';
import 'package:test/screens/screen_frame.dart';
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
  TextEditingController userPassword = TextEditingController();
  TextEditingController userPasswordCheck = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhoneNumber = TextEditingController();

  void setData() {
    widget.user.userPassword = userPassword.text;
    widget.user.userPasswordCheck = userPasswordCheck.text;
    widget.user.userEmail = userEmail.text;
    widget.user.userPhoneNumber = userPhoneNumber.text;
  }

  String validationCheck() {
    List<String Function()> validationMethods = [
      widget.user.passwordCheck,
      widget.user.passwordEqualCheck,
      widget.user.emailCheck,
      widget.user.phoneNumberCheck,
    ];

    for (var validationMethod in validationMethods) {
      String returnMessage = validationMethod();
      if (returnMessage.isNotEmpty) {
        return returnMessage;
      }
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      bottomBar: false,
      appBarType: BarType.exit,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleText(
                text: '회원가입',
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
                keyboardType: TextInputType.visiblePassword,
                controller: userPassword,
                textInputAction: TextInputAction.next,
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
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                controller: userPasswordCheck,
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
                keyboardType: TextInputType.emailAddress,
                controller: userEmail,
                textInputAction: TextInputAction.next,
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
                keyboardType: TextInputType.phone,
                controller: userPhoneNumber,
                textInputAction: TextInputAction.done,
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
                    setData();
                    String validationMessage = validationCheck();
                    if (validationMessage.isNotEmpty) {
                      AppCore.showMessage(context, '회원가입', validationMessage, ActionType.ok, () {
                        Navigator.pop(context);
                      });
                      return;
                    }
                    widget.user.userRegist().then((String result) {
                      if (result == "0") {
                        AppCore.showMessage(context, '회원가입', '가입 완료', ActionType.ok, () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()),);
                        });
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
          ),
        ),
      )
    );
  }
}