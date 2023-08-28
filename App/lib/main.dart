import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/screens/home.dart';
import 'app_core.dart';
import 'initialize.dart';
import 'models/user.dart';
import 'screens/first_run.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  late Future<User> isInitialized;

  @override
  void initState() {
    super.initState();

    setState(() {
      isInitialized = AppCore.instance.getUserDB();
    });
  }

  Widget _splashLoadingWidget() {
    if (AppCore.instance.getUser().isLoginSucess) {
      return const Home();
    }
    else {
      return const FirstRun();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(900, 1600),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '산돌교회',
          theme: ThemeData(
            primaryColor: Color.fromARGB(255, 90, 68, 223),
          ),
          home: FutureBuilder(
            future: isInitialized,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Initialize();
              }
              else if (snapshot.hasError) {
                AppCore.showMessage(context, '', '실행 중 오류가 발생하였습니다.', ActionType.ok, () {
                  Navigator.pop(context);
                });
                return Container();
              }
              else {
                return  AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
                child: _splashLoadingWidget(),
                );
              }
            }
          ),
        );
      }
    );
  }
}