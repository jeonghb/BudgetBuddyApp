// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:test/LogIn.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/UserRegistCheck.dart';

class FirstRun extends StatelessWidget {
  const FirstRun({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { FocusScope.of(context).unfocus();},
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil().setHeight(200),
                  ),
                  Text('SANDOL',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(700),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(130),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )
                      ),
                      child: Text('로그인',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 90, 68, 223),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(50),
                  ),
                  MoveLogInPage(
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MoveLogInPage extends StatefulWidget {
  const MoveLogInPage({super.key});

  @override
  State<MoveLogInPage> createState() => _MoveLogInPage();
}

class _MoveLogInPage extends State<MoveLogInPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Text('아직 회원이 아니신가요?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          TextButton(
            child: Text('회원가입',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegistCheck()),);
            },
          ),
        ],
      )
    );
  }
}