import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'initialize.dart';
// import 'dart:developer' as developer;

void main() async {
  // developer.debugger();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(900, 1600),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BudgetBuddy',
          theme: ThemeData(
            primaryColor: Color.fromARGB(255, 90, 68, 223),
          ),
          home: Initialize(),
        );
      }
    );
  }
}