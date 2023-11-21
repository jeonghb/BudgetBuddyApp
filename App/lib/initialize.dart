// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:test/screens/group/group_main.dart';
import 'package:test/screens/first_run.dart';

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

    Future.delayed(Duration(seconds: 3), () {
      Navigator.popUntil(context, ModalRoute.withName('/'));
      if (AppCore.instance.getUser().isLoginSucess) {
        if (AppCore.instance.getUser().groupList.isNotEmpty) {
          AppCore.instance.getUser().selectGroupId = AppCore.instance.getUser().groupList[0].groupId;
          Navigator.push(context, MaterialPageRoute(builder: (context) => Home(groupId: AppCore.instance.getUser().selectGroupId)),);
        }
        else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => GroupMain()),);
        }
      }
      else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => FirstRun()),);
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