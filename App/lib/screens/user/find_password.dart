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

  bool validationCheck() {
    if (!user.idRegexCheck()
      || !user.nameRegexCheck()
      || user.userBirthdayYear.text.trim().replaceAll('0', '').length != 4
      || user.userBirthdayMonth.text.trim().replaceAll('0', '').isEmpty
      || user.userBirthdayDay.text.trim().replaceAll('0', '').isEmpty) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => { FocusScope.of(context).unfocus()},
      child: Scaffold(
        appBar: TopBar(type: BarType.logout),
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
                    controller: user.userId,
                    textInputAction: TextInputAction.next,
                    validator: (value) { return user.idCheck();},
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
                    controller: user.userName,
                    textInputAction: TextInputAction.next,
                    validator: (value) { return user.nameCheck();},
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
                          controller: user.userBirthdayYear,
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
                          controller: user.userBirthdayMonth,
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
                          controller: user.userBirthdayDay,
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
                              BorderSide(width: 1, color:  user.userSex == 'male' ? Color.fromARGB(255, 90, 68, 223) : Colors.grey),
                            ),
                            minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
                          ),
                          onPressed: () => {
                            FocusScope.of(context).unfocus(),
                            user.userSex = 'male',
                            setState(() => user.userSex)
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
                              BorderSide(width: 1, color:  user.userSex == 'female' ? Color.fromARGB(255, 90, 68, 223) : Colors.grey),
                            ),
                            minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
                          ),
                          onPressed: () => {
                            FocusScope.of(context).unfocus(),
                            user.userSex = 'female',
                            setState(() => user.userSex)
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
                        ResponseData responseData = await user.userPasswordFind();
                        if (responseData.statusCode == 200 && responseData.body.toString() == 'false') {
                          AppCore.showMessage(context, '비밀번호 찾기', '일치하는 정보가 없습니다.', ActionType.ok, () {
                            Navigator.pop(context);
                          });
                        }
                        else if (responseData.statusCode == 200 && responseData.body.toString() == 'true') {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePassword(user: user)),);
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