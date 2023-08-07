import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:test/app_core.dart';
import 'package:test/models/response_data.dart';
import 'Position.dart';
import 'department.dart';

class User with ChangeNotifier {
  TextEditingController userId = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userPasswordCheck = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhoneNumber = TextEditingController();
  String userBirthday = DateTime.now().toString();
  TextEditingController userBirthdayYear = TextEditingController();
  TextEditingController userBirthdayMonth = TextEditingController();
  TextEditingController userBirthdayDay = TextEditingController();
  String userSex = 'male';
  int bankId = 1;
  String bankName = '기업은행';
  TextEditingController bankAccountNumber = TextEditingController();
  List<Department> departmentList = <Department>[];
  // Image? image;
  bool isLoginSucess = false;
  
  static RegExp idRegExp = RegExp(r'[\W]|[\\\[\]\^\`]');
  static RegExp passwordRegExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}');
  static RegExp nameRegExp = RegExp(r'[가-힣]');
  static RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  static RegExp phoneNumberRegExp = RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$');

  registStatus() {
    userBirthday = DateTime.now().toString();
    userSex = 'male';
  }

  String getUserBirthday() {
    if (userBirthdayYear.text.length != 4 && userBirthdayMonth.text.length != 2 && userBirthdayDay.text.length != 2) {
      return DateTime.now().toString();
    }
    else {
      return '${userBirthdayYear.text.padLeft(4, '0')}-${userBirthdayMonth.text.padLeft(2, '0')}-${userBirthdayDay.text.padLeft(2, '0')}';
    }
  }

  void setUserBirthday() {
    userBirthdayYear.text = userBirthday.substring(0, 4);
    userBirthdayMonth.text = userBirthday.substring(5, 2);
    userBirthdayDay.text = userBirthday.substring(8, 2);
  }

  Future<ResponseData> isUserCheck() async {
    String address = '/userCheck';
    Map<String, String> body = {
      'userName': userName.text,
      'userBirthday': getUserBirthday(),
      'userSex': userSex
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200 && responseData.body.isNotEmpty) {
      userId.text = responseData.body.toString();
    }

    return responseData;
  }

  Future<String> userRegist() async {
    String address = '/userRegist';
    Map<String, dynamic> body = {
      'userId': userId.text,
      'userPassword': sha512.convert(utf8.encode(userPassword.text)).toString(),
      'userName': userName.text,
      'userEmail': userEmail.text,
      'userPhoneNumber': userPhoneNumber.text,
      'userBirthday': userBirthday,
      'userSex': userSex,
    };
    
    ResponseData response = await AppCore.request(ServerType.POST, address, body);

    return response.body;
  }

  Future<String> userUpdate() async {
    String address = '/userInfoUpdate';
    Map<String, dynamic> body = {
      'userId' : userId.text,
      'userEmail': userEmail.text,
      'userPhoneNumber': userPhoneNumber.text,
      'bankId': bankId,
      'bankAccountNumber' : bankAccountNumber.text,
    };
    
    ResponseData response = await AppCore.request(ServerType.POST, address, body);

    return response.body;
  }

  bool idRegexCheck() {
    return idRegExp.hasMatch(userId.text);
  }

  bool passwordRegexCheck() {
    return passwordRegExp.hasMatch(userPassword.text);
  }

  bool passwordSameCheck() {
    return userPassword.text == userPasswordCheck.text;
  }

  bool nameRegexCheck() {
    return nameRegExp.hasMatch(userName.text);
  }

  bool emailRegexCheck() {
    return emailRegExp.hasMatch(userEmail.text);
  }

  bool phoneNumberRegexCheck() {
    return phoneNumberRegExp.hasMatch(userPhoneNumber.text);
  }

  String? idCheck() {
    return userId.text == '' || userId.text.length < 5 || idRegexCheck() ? '5자 이상이어야 하며, 특수문자는 _만 사용 가능합니다.' : null;
  }

  String? passwordCheck() {
    return userPassword.text == '' || !passwordRegexCheck() ? '알파벳 대문자, 소문자, 숫자, 특수문자를 반드시 포함하여 8자 이상 입력하세요.' : null;
  }

  String? passwordEqualCheck() {
    return userPasswordCheck.text == '' ? '비밀번호를 입력해주세요.' : userPasswordCheck.text != userPassword.text ? '입력한 비밀번호와 일치하지 않습니다.' : null;
  }

  String? nameCheck() {
    return userName.text == '' || userName.text.length < 2 || !nameRegexCheck() ? '정상적인 이름 형식이 아닙니다.' : null;
  }

  String? emailCheck() {
    return userEmail.text == '' || !emailRegexCheck() ? '정상적인 이메일 형식이 아닙니다.' : null;
  }

  String? phoneNumberCheck() {
    return userPhoneNumber.text == '' || !phoneNumberRegexCheck() ? '정상적인 휴대폰번호 형식이 아닙니다.' : null;
  }

  Future<String> userLogin(bool isPasswordEncode) async {
    String address = '/login';
    Map<String, String> body = {
      'userId': userId.text,
      'userPassword': isPasswordEncode ? sha512.convert(utf8.encode(userPassword.text)).toString() : userPassword.text
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200) {
      if (json.decode(responseData.body)['logInIsSuccess']) {
        userName.text = json.decode(responseData.body)['userName'];
        userEmail.text = json.decode(responseData.body)['userEmail'];
        userPhoneNumber.text = json.decode(responseData.body)['userPhoneNumber'];
        userBirthday = json.decode(responseData.body)['userBirthday'];
        userSex = json.decode(responseData.body)['userSex'];
        isLoginSucess = true;

        // 부서, 직책 조회
        address = '/getLoginUserDepartmentPositionList';
        body = {
          'userId': userId.text
        };

        responseData = await AppCore.request(ServerType.POST, address, body);

        if (responseData.statusCode == 200) {
          for (var jsonDepartment in jsonDecode(responseData.body)) {
            Department department = Department();
            department.setData(jsonDepartment);

            if (departmentList.where((element) => element.departmentId == department.departmentId).isEmpty) {
              departmentList.add(department);
            }

            Position position = Position();
            position.setData(jsonDepartment);
            departmentList.firstWhere((element) => element.departmentId == department.departmentId).positionList.add(position);
          }
        }

        return '0';
      }
      else {
        isLoginSucess = false;
        return '1';
      }
    }
    else {
      isLoginSucess = false;
      return '2';
    }
  }

  Future<ResponseData> userPasswordFind() async {
    String address = '/userPasswordFind';
    Map<String, String> body = {
      'userId': userId.text,
      'userName': userName.text,
      'userBirthday': getUserBirthday(),
      'userSex': userSex,
    };

    return await AppCore.request(ServerType.POST, address, body);
  }

  Future<ResponseData> userUpdatePassword() async {
    String address = '/userPasswordUpdate';
    Map<String, String> body = {
      'userId': userId.text,
      'userPassword': sha512.convert(utf8.encode(userPassword.text)).toString(),
    };

    return await AppCore.request(ServerType.POST, address, body);
  }

  bool passwordAuthCheck(String password) {
    if (userPassword.text == sha512.convert(utf8.encode(password)).toString()) {
      return true;
    }
    
    return false;
  }
}