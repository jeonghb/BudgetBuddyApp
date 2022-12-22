// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:test/Regist.dart';
import 'package:test/LogIn.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(900, 1600),
      builder: (context, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '산돌교회',
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 190, 180, 170),
          fontFamily: 'KOTRA HOPE',
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              fontSize: 20,
              color: Colors.black,
            )
          ),
          scaffoldBackgroundColor: Color.fromARGB(255, 241, 237, 233),
        ),
        home: MyHomePage(), 
      );
    });
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
                    height: ScreenUtil().setHeight(220),
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/sandol youth praise team.png'),
                    radius: 60.0,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(85),
                  ),
                  Text('환영합니다',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(470),
                  ),
                  MoveLogInPage(
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(85),
                  ),
                  ElvbOpenRegistPage(
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
    return Center(
      child: TextButton(
        child: 
          Text(
            '이미 가입되어 있으신가요?',
            style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 238, 135, 128)
            // decoration: TextDecoration.underline,
            ),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()),
            );
          },
      )
    );
  }
}

class ElvbOpenRegistPage extends StatefulWidget {
  const ElvbOpenRegistPage({super.key});

  @override
  State<ElvbOpenRegistPage> createState() => _TxtBtnOpenRegistPage();
}

class _TxtBtnOpenRegistPage extends State<ElvbOpenRegistPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: ScreenUtil().setHeight(130),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 190, 180, 170),
          ),
          child: Text('다음',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black
          ),),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => RegistPage()),
            );
          },
        ),
      ),
    );
  }
}