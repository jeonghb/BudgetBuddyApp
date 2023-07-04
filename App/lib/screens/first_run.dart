// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:test/screens/login.dart';
import 'package:test/screens/user_regist_check.dart';

class FirstRun extends StatelessWidget {
  const FirstRun({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { FocusScope.of(context).unfocus();},
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 90, 68, 223),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'SANDOL',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'GOOGLE SEN',
                  ),
                ),
              )
            ),
            Expanded(
              child: SizedBox(
              )
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                    )
                  ),
                  Expanded(
                    flex: 7,
                    child: SizedBox(
                      height: double.infinity,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
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
                  ),
                  Expanded(
                    child: SizedBox(
                    )
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text('아직 회원이 아니신가요?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: TextButton(
                      child: Text('회원가입',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegistCheck(userType: UserType.newUser,)),);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                    ),
                  ),
                ],
              )
            ),
            Expanded(
              child: SizedBox(
              ),
            ),
          ],
        ),
      ),
    );
  }
}