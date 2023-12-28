// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/app_core.dart';
import 'package:test/screens/user/update_password.dart';

import '../../models/response_data.dart';
import '../../models/user.dart';
import '../../widgets/text_form_field_v1.dart';
import '../../widgets/title_text.dart';
import '../../widgets/top_bar.dart';

class FindPassword extends StatefulWidget {
  const FindPassword({super.key});

  @override
  State<FindPassword> createState() => _FindPassword();
}

class _FindPassword extends State<FindPassword> {
  User user = User();
  TextEditingController userId = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userPasswordCheck = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhoneNumber = TextEditingController();
  TextEditingController userBirthdayYear = TextEditingController();
  TextEditingController userBirthdayMonth = TextEditingController();
  TextEditingController userBirthdayDay = TextEditingController();
  TextEditingController userSex = TextEditingController();

  @override
  void initState() {
    super.initState();

    userSex.text = 'male';
  }

  void setData() {
    user.userId = userId.text;
    user.userPassword = userPassword.text;
    user.userPasswordCheck = userPasswordCheck.text;
    user.userName = userName.text;
    user.userEmail = userEmail.text;
    user.userPhoneNumber = userPhoneNumber.text;
    user.userBirthdayYear = userBirthdayYear.text;
    user.userBirthdayMonth = userBirthdayMonth.text;
    user.userBirthdayDay = userBirthdayDay.text;
    user.userSex = userSex.text;
  }

  Future<ResponseData> userPasswordFind() async {
    return await user.userPasswordFind();
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
                    text: '비밀번호 찾기',
                  ),
                  Text('아이디',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldV1(
                    hintText: 'ID',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.name,
                    controller: userId,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('이름',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormFieldV1(
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.name,
                    controller: userName,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('생년월일',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: TextFormFieldV1(
                          counterText: '',
                          suffixIcon: Container(
                            width: 50,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Text(
                              '년',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          maxLength: 4,
                          keyboardType: TextInputType.number,
                          controller: userBirthdayYear,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {FocusScope.of(context).nextFocus();},
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 3,
                        child: TextFormFieldV1(
                          counterText: '',
                          suffixIcon: Container(
                            width: 50,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Text(
                              '월',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          maxLength: 2,
                          keyboardType: TextInputType.number,
                          controller: userBirthdayMonth,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {FocusScope.of(context).nextFocus();},
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 3,
                        child: TextFormFieldV1(
                          counterText: '',
                          suffixIcon: Container(
                            width: 50,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Text(
                              '일',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          maxLength: 2,
                          keyboardType: TextInputType.number,
                          controller: userBirthdayDay,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {FocusScope.of(context).nextFocus();},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextButton(
                          style: ButtonStyle(
                            side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(width: 1, color: userSex.text == 'male' ? Color.fromARGB(255, 90, 68, 223) : Colors.grey),
                            ),
                            minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
                            overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
                          ),
                          onPressed: () => {
                            FocusScope.of(context).unfocus(),
                            userSex.text = 'male',
                            setState(() => userSex)
                          },
                          child: Text('남',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: TextButton(
                          style: ButtonStyle(
                            side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(width: 1, color:  userSex.text == 'female' ? Color.fromARGB(255, 90, 68, 223) : Colors.grey),
                            ),
                            minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
                            overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
                          ),
                          onPressed: () => {
                            FocusScope.of(context).unfocus(),
                            userSex.text = 'female',
                            setState(() => userSex)
                          },
                          child: Text('여',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(120),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: Text('조회',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();

                        setData();

                        ResponseData responseData = await userPasswordFind();
                        if (responseData.statusCode == 200 && responseData.body.toString() == 'false') {
                          AppCore.showMessage(context, '비밀번호 찾기', '일치하는 정보가 없습니다.', ActionType.ok, () {
                            Navigator.pop(context);
                          });
                        }
                        else if (responseData.statusCode == 200 && responseData.body.toString() == 'true') {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePassword()),);
                        }
                        else {
                          AppCore.showMessage(context, '비밀번호 찾기', '가입정보를 확인 중 오류가 발생하였습니다. 다시 시도해주세요.', ActionType.ok, () {
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