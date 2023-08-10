import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/models/user.dart';
import 'package:test/screens/user/user_regist.dart';
import 'package:test/widgets/top_bar.dart';
import '../../models/response_data.dart';
import '../../widgets/text_form_field_v1.dart';
import '../login.dart';

class UserRegistCheck extends StatefulWidget {
  final UserType userType;

  const UserRegistCheck({super.key, required this.userType});

  @override
  State<UserRegistCheck> createState() => _UserRegistCheck();
}

class _UserRegistCheck extends State<UserRegistCheck> {
  User user = User();
  String birthday = '';
  bool male = true;
  bool female = false;
  late List<bool> isSelected = [male, female];

  bool userRegistCheckValidationCheck() {
    if (user.userBirthdayYear.text.trim().replaceAll('0', '').length != 4
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
                  Text(widget.userType == UserType.newUser ? '회원가입' : '아이디 찾기',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                      child: Text(widget.userType == UserType.newUser ? '다음' : '조회',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (!userRegistCheckValidationCheck()) {
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                title: widget.userType == UserType.newUser ? Text('회원가입') : Text('아이디 찾기'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const <Widget>[Text('정상적으로 입력되지 않은 항목이 있습니다. 확인 후 다시 시도해주세요.',),],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('확인'), 
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            },
                          );
                          return;
                        }
                        
                        ResponseData responseData = await user.isUserCheck();
                        if (responseData.statusCode == 200 && user.userId.text.isEmpty) {
                          switch (widget.userType) {
                            case UserType.newUser:
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegist(user: user)),);
                              break;
                            case UserType.findUser:
                              showDialog(
                                context: context, 
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    title: Text('회원가입'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const <Widget>[Text('가입된 정보가 없습니다.\n회원가입을 진행하시겠습니까?',),],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('취소'), 
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: Text('확인'), 
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegist(user: user)),);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                              break;
                          }
                        }
                        else if (responseData.statusCode == 200 && user.userId.text.isNotEmpty) {
                          switch (widget.userType) {
                            case UserType.newUser:
                              showDialog(
                                context: context, 
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    title: Text('회원가입'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const <Widget>[Text("이미 가입된 정보가 있습니다. 로그인 화면으로 이동합니다.",),],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('확인'), 
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()),);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                              break;
                            case UserType.findUser:
                              showDialog(
                                context: context, 
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    title: Text('아이디 찾기'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[Text("가입된 ID는 ${user.userId.text.substring(0, 4)}${Iterable.generate(user.userId.text.length - 4, (_) => '*').join()}입니다.",),],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('확인'), 
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()),);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                              break;
                          }
                        }
                        else {
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                title: Text(widget.userType == UserType.newUser ? '회원가입' : '아이디 찾기'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const <Widget>[Text("가입정보를 확인 중 오류가 발생하였습니다. 다시 시도해주세요.",),],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('확인'), 
                                    onPressed: () {Navigator.pop(context);},
                                  )
                                ],
                              );
                            }
                          );
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

enum UserType {
  newUser,
  findUser
}