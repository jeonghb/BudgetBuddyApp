import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/first_run.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

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
          fontFamily: 'GOOGLE SEN',
          textTheme: GoogleFonts.senTextTheme(TextTheme().copyWith(
            bodyLarge: GoogleFonts.oswald(
              fontSize: 50,
              color: Colors.white,
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
              )
            ),
          )),
          scaffoldBackgroundColor: Color.fromARGB(255, 90, 68, 223),
        ),
        home: FirstRun(), 
      );
    });
  }
}