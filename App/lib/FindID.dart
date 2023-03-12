import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/widget/BirthdaySelect.dart';
import 'package:test/widget/SexSelect.dart';

import 'class/User.dart';

class FindID extends StatefulWidget {
  FindID({super.key});

  @override
  State<FindID> createState() => _FindID();
}
    
User user = User();

class _FindID extends State<FindID> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => { FocusScope.of(context).unfocus()},
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.fromLTRB(30, 100, 30, 100),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: '이름',
                      hintText: '홍길동',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 223, 219, 215))
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 219, 215),
                      labelStyle: TextStyle(
                        fontSize: 35
                      ),
                    ),
                    autofocus: true,
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.name,
                    controller: user.name,
                    textInputAction: TextInputAction.done,
                    validator: (value) { return user.nameCheck(value);},
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: <Widget>[
                      BirthdaySelectWidget(),
                      SizedBox(width: 45),
                      SexSelectWidget(sex: 'male'),
                    ],
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(120),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 190, 180, 170),
                      ),
                      child: Text('아이디 찾기',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black
                      ),),
                      onPressed: () {
                        user.Check().then((String result) {
                          if (result == "0") {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegist(user)),);
                          }
                          else if (result == "1") {
                            showDialog(
                              context: context, 
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  title: Column(children: <Widget>[Text('회원가입')]),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[Text("이미 가입된 정보가 있습니다. 로그인 화면으로 이동합니다.",),],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('확인'), 
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()),);
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          }
                          else {
                            showDialog(
                              context: context, 
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  title: Column(children: <Widget>[Text('회원가입')]),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[Text("가입정보를 확인 중 오류가 발생하였습니다. 다시 시도해주세요.",),],
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
                        });
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