import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/screens/find_user.dart';
import 'package:test/models/user.dart';
import 'package:test/screens/home.dart';

import '../app_core.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPage();
}

class _LogInPage extends State<LogInPage> {
  User user = User();
  bool isAutoLogIn = true;

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
                        child: Text('\n\nSANDOL',
                          style: Theme.of(context).textTheme.bodyText1,
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
                      TextFormField(
                        decoration: InputDecoration(hintText: '아이디를 입력해주세요.',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
                          ),
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 90, 68, 223)
                            ),
                          prefixIcon: Image.asset('assets/images/ID1.png'),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        keyboardType: TextInputType.name,
                        controller: user.userId,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: '비밀번호를 입력해주세요.',
                            focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
                          ),
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 90, 68, 223)
                          ),
                          prefixIcon: Image.asset('assets/images/PW1.png'),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: TextStyle(
                            fontSize: 35
                          ),
                        ),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: user.userPassword,
                        textInputAction: TextInputAction.done,
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            activeColor: Colors.white,
                            checkColor: Color.fromARGB(255, 90, 68, 223),
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(width: 1.0, color: Colors.grey),
                            ),
                            value: isAutoLogIn,
                            onChanged: (bool? value) {
                              setState(() {
                                isAutoLogIn = value ?? false;
                              });
                            }
                          ),
                          Text('자동로그인'),
                          SizedBox(
                            width: 180,
                          )
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: ScreenUtil().setHeight(130),
                        child: TextButton(
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
                          onPressed: () {
                            user.login(true).then((String result) async {
                              if (result == "0") {
                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                if (isAutoLogIn) {
                                  preferences.setBool('autoLogin', true);
                                  preferences.setString('userId', user.userId.text);
                                  preferences.setString('userPassword', sha512.convert(utf8.encode(user.userPassword.text)).toString());
                                }
                                else {
                                  preferences.setBool('autoLogin', false);
                                  preferences.setString('userId', '');
                                  preferences.setString('userPassword', '');
                                }

                                AppCore.getInstance().setUser(user);

                                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);
                              }
                              else if (result == "1") {
                                showDialog(
                                  context: context, 
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      title: Column(children: <Widget>[Text('로그인')]),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[Text("잘못된 정보입니다.",),],
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
                                      title: Column(children: <Widget>[Text('로그인')]),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[Text("로그인 중 오류가 발생하였습니다. 다시 시도해주세요.",),],
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
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextButton(
                            child: Text('아이디 찾기',
                              style: TextStyle(
                                color: Colors.black
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FindID()),
                              );
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('|'),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            child: Text('비밀번호 찾기',
                              style: TextStyle(
                                color: Colors.black
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()),
                              );
                            },
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