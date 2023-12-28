// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/app_core.dart';
import 'package:test/screens/login.dart';

import '../../models/response_data.dart';
import '../../models/user.dart';
import '../../widgets/text_form_field_v1.dart';
import '../../widgets/title_text.dart';
import '../../widgets/top_bar.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<StatefulWidget> createState() => _UpdatePassword();
}

class _UpdatePassword extends State<UpdatePassword> {
  User user = User();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userPasswordCheck = TextEditingController();

  @override
  void initState() {
    super.initState();

    user.userId = AppCore.instance.getUser().userId;
  }

  bool validationCheck() {
    if (!user.passwordRegexCheck() || !user.passwordSameCheck()) {
      return false;
    }

    return true;
  }

  Future<ResponseData> userUpdatePassword() async {
    setData();

    return await user.userUpdatePassword();
  }

  void setData() {
    user.userPassword = userPassword.text;
    user.userPasswordCheck = userPasswordCheck.text;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => { FocusScope.of(context).unfocus()},
      child: Scaffold(
        appBar: TopBar(type: BarType.exit),
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TitleText(
                    text: '비밀번호 변경',
                  ),
                  Text('비밀번호',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldV1(
                    hintText: '●●●●●●●●',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.visiblePassword,
                    controller: userPassword,
                    textInputAction: TextInputAction.next,
                    validator: (value) { 
                      return user.passwordCheck();
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('비밀번호 확인',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldV1(
                    hintText: '●●●●●●●●',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    controller: userPasswordCheck,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(120),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: Text('변경',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (!validationCheck()) {
                          AppCore.showMessage(context, '비밀번호 변경', '정상적으로 입력되지 않은 항목이 있습니다. 확인 후 다시 시도해주세요.', ActionType.ok, () {
                            Navigator.pop(context);
                          });
                          return;
                        }

                        ResponseData responseData = await userUpdatePassword();
                        if (responseData.statusCode == 200 && responseData.body.isEmpty) {
                          AppCore.showMessage(context, '비밀번호 변경', '일치하는 정보가 없습니다.', ActionType.ok, () {
                            Navigator.pop(context);
                          });
                        }
                        else if (responseData.statusCode == 200 && AppCore.instance.getUser().userId.isNotEmpty) {
                          await showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                title: Text('비밀번호 변경'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const <Widget>[Text("비밀번호 변경이 완료되었습니다. 로그인 화면으로 이동합니다.",),],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      AppCore.instance.logOut();
                                    },
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
                                    ),
                                    child: Text('확인'), 
                                  )
                                ],
                              );
                            }
                          );
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LogInPage(), settings: RouteSettings(name: '/Login'),), (route) => false);
                        }
                        else {
                          AppCore.showMessage(context, '비밀번호 변경', '비밀번호를 변경하는 중 오류가 발생하였습니다. 다시 시도해주세요.', ActionType.ok, () {
                            Navigator.pop(context);
                          });
                        }
                      },
                    ),
                  ),
                ]
              )
            )
          )
        )
      )
    );
  }
}