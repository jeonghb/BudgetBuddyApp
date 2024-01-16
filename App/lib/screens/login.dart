// ignore_for_file: use_build_context_synchronously
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/initialize.dart';
import 'package:test/models/user.dart';
import 'package:test/screens/user/find_password.dart';
import 'package:test/screens/user/user_regist_check.dart';

import '../app_core.dart';
import '../widgets/text_form_field_v1.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPage();
}

class _LogInPage extends State<LogInPage> {
  TextEditingController userId = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  void login() {
    User user = User();
    user.userId = userId.text;
    user.userPassword = userPassword.text;
    
    user.userLogin(true).then((String result) async {
      if (result == "0") {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('autoLogin', true);
        preferences.setString('userId', user.userId);
        preferences.setString('userPassword', sha512.convert(utf8.encode(user.userPassword)).toString());

        AppCore.instance.setUser(user);

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Initialize()), (route) => false,);
      }
      else if (result == "1") {
        AppCore.showMessage(context, '로그인', '잘못된 정보입니다.', ActionType.ok, () {
          Navigator.pop(context);
        });
      }
      else {
        AppCore.showMessage(context, '로그인', '로그인 중 오류가 발생하였습니다. 다시 시도해주세요.', ActionType.ok, () {
          Navigator.pop(context);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => { FocusScope.of(context).unfocus()},
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // if (AppCore.isLoading) CircularProgressIndicator(),
              Positioned(
                top: 0,
                child: ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: 300,
                    color: Color.fromARGB(255, 90, 68, 223),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle
                        ),
                        child: Text('\n\nBudgetBuddy',
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'GOOGLE SEN',
                          ),
                        ),
                      )
                    )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Text('로그인',
                  style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      TextFormFieldV1(
                        hintText: '아이디를 입력해주세요.',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 90, 68, 223)
                        ),
                        prefixIcon: Image.asset('assets/images/ID1.png'),
                        keyboardType: TextInputType.name,
                        controller: userId,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                          FocusScope.of(context).nextFocus();
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormFieldV1(
                        hintText: '비밀번호를 입력해주세요.',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 90, 68, 223)
                        ),
                        prefixIcon: Image.asset('assets/images/PW1.png'),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: userPassword,
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                          login();
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: ScreenUtil().setHeight(130),
                        child: TextButton(
                          onPressed: () {
                            login();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 90, 68, 223),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                          ),
                          child: Text('로그인',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegistCheck()),);
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
                            ),
                            child: Text('회원가입',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('|'),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FindPassword()),
                              );
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
                            ),
                            child: Text('비밀번호 찾기',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      )
                    ]
                  ),
                )
              ),
            ]
          )
        )
      )
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.8);

    path.quadraticBezierTo(size.width / 2, size.height * 1.1, size.width, size.height * 0.8);
    
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}