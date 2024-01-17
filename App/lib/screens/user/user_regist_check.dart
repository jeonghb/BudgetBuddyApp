import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/app_core.dart';
import 'package:test/models/user.dart';
import 'package:test/screens/user/user_regist.dart';
import 'package:test/widgets/top_bar.dart';
import '../../models/response_data.dart';
import '../../widgets/text_form_field_v1.dart';
import '../../widgets/title_text.dart';
import '../screen_frame.dart';

class UserRegistCheck extends StatefulWidget {
  const UserRegistCheck({super.key,});

  @override
  State<UserRegistCheck> createState() => _UserRegistCheck();
}

class _UserRegistCheck extends State<UserRegistCheck> {
  User user = User();
  TextEditingController userId = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController userBirthdayYear = TextEditingController();
  TextEditingController userBirthdayMonth = TextEditingController();
  TextEditingController userBirthdayDay = TextEditingController();
  
  String birthday = '';
  bool male = true;
  bool female = false;
  late List<bool> isSelected = [male, female];

  @override
  void initState() {
    super.initState();
  }

  String userRegistCheckValidationCheck() {
    List<String Function()> validationMethods = [
      user.idCheck,
      user.nameCheck,
      user.birthdayCheck,
    ];

    for (var validationMethod in validationMethods) {
      String returnMessage = validationMethod();
      if (returnMessage.isNotEmpty) {
        return returnMessage;
      }
    }

    if (!DateTime.now().isAfter(DateTime(int.parse(user.userBirthdayYear) + 19, int.parse(user.userBirthdayMonth), int.parse(user.userBirthdayDay)))) {
      return '현재 성인만 가입 가능합니다';
    }

    return '';
  }

  void setData() {
    user.userId = userId.text;
    user.userName = userName.text;
    user.userBirthdayYear = userBirthdayYear.text;
    user.userBirthdayMonth = userBirthdayMonth.text;
    user.userBirthdayDay = userBirthdayDay.text;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      bottomBar: false,
      appBarType: BarType.exit,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleText(
                  text: '회원가입',
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
                Text(
                  '이름',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormFieldV1(
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
                Text(
                  '생년월일',
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
                            BorderSide(width: 1, color:  user.userSex == 'male' ? Color.fromARGB(255, 90, 68, 223) : Colors.grey),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
                          overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
                        ),
                        onPressed: () => {
                          FocusScope.of(context).unfocus(),
                          setState(() => user.userSex = 'male')
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
                          overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
                        ),
                        onPressed: () => {
                          FocusScope.of(context).unfocus(),
                          setState(() => user.userSex = 'female')
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
                    child: Text('다음',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                    ),),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();

                      setData();

                      String validationMessage = userRegistCheckValidationCheck();
                      if (validationMessage.isNotEmpty) {
                        AppCore.showMessage(context, '회원가입', validationMessage, ActionType.ok, () {
                          Navigator.pop(context);
                        });
                        return;
                      }

                      ResponseData responseData = await user.isUserCheck();

                      if (responseData.statusCode == 200) {
                        if (responseData.body == 'true') {
                          // ignore: use_build_context_synchronously
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegist(user: user)),);
                        }
                        else {
                          // ignore: use_build_context_synchronously
                          AppCore.showMessage(context, '회원가입', '이미 가입된 정보가 있거나 해당 아이디를 사용할 수 없습니다', ActionType.ok, () {
                            Navigator.pop(context);
                          });
                        }
                      }
                      else {
                        // ignore: use_build_context_synchronously
                        AppCore.showMessage(context, '회원가입', '가입정보를 확인 중 오류가 발생하였습니다. 다시 시도해주세요', ActionType.ok, () {
                          Navigator.pop(context);
                        });
                      }
                    },
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}