// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:test/screens/group/group_main.dart';
import 'package:test/screens/login.dart';

import 'app_core.dart';
import 'screens/home.dart';

class Initialize extends StatefulWidget {
  const Initialize({super.key});

  @override
  State<Initialize> createState() => _Initialize();
}

class _Initialize extends State<Initialize> {

  @override
  void initState() {
    super.initState();
    
    pageMove();
  }

  void pageMove() async {
    await AppCore.instance.getUserDB();

    Future.delayed(Duration(seconds: 1), () {
      if (AppCore.instance.getUser().isLoginSucess) {
        if (AppCore.instance.getUser().groupList.isNotEmpty) {
          AppCore.instance.getUser().selectGroup = AppCore.instance.getUser().groupList[0];
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home(groupId: AppCore.instance.getUser().selectGroup.groupId), settings: RouteSettings(name: '/Home'),), (route) => false);
        }
        else {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => GroupMain(), settings: RouteSettings(name: '/GroupMain'),), (route) => false);
        }
      }
      else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LogInPage(), settings: RouteSettings(name: '/Login'),), (route) => false,);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 90, 68, 223),
      body: Center(
        child: Text('BudgetBuddy',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}