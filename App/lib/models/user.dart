import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';
import 'package:test/app_core.dart';
import 'package:test/models/response_data.dart';
import 'group.dart';
import 'position.dart';
import 'auth.dart';
import 'department.dart';

class User {
  String userId = '';
  String userPassword = '';
  String userPasswordCheck = '';
  String userName = '';
  String userEmail = '';
  String userPhoneNumber = '';
  String userBirthday = DateTime.now().toString();
  String userBirthdayYear = '';
  String userBirthdayMonth = '';
  String userBirthdayDay = '';
  String userSex = 'male';
  int bankId = -1;
  String bankName = '';
  String bankAccountNumber = '';
  List<Group> groupList = <Group>[];
  int selectGroupId = -1;
  List<Department> departmentList = <Department>[];
  // Image? image;
  bool isLoginSucess = false;
  bool isManager = false;

  RegExp idRegExp = RegExp(r'[\W]|[\\\[\]\^\`]');
  RegExp passwordRegExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}');
  RegExp nameRegExp = RegExp(r'[가-힣]');
  RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  RegExp phoneNumberRegExp = RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$');

  String? idCheck() {
    return userId == '' || userId.length < 5 || idRegexCheck() ? '5자 이상이어야 하며, 특수문자는 _만 사용 가능합니다.' : null;
  }

  bool idRegexCheck() {
    return idRegExp.hasMatch(userId);
  }

  bool passwordRegexCheck() {
    return passwordRegExp.hasMatch(userPassword);
  }

  bool passwordSameCheck() {
    return userPassword == userPasswordCheck;
  }

  bool nameRegexCheck() {
    return nameRegExp.hasMatch(userName);
  }

  bool emailRegexCheck() {
    return emailRegExp.hasMatch(userEmail);
  }

  bool phoneNumberRegexCheck() {
    return phoneNumberRegExp.hasMatch(userPhoneNumber);
  }

  String? passwordCheck() {
    return userPassword == '' || !passwordRegexCheck() ? '알파벳 대문자, 소문자, 숫자, 특수문자를 반드시 포함하여 8자 이상 입력하세요.' : null;
  }

  String? passwordEqualCheck() {
    return userPasswordCheck == '' ? '비밀번호를 입력해주세요.' : userPasswordCheck != userPassword ? '입력한 비밀번호와 일치하지 않습니다.' : null;
  }

  String? nameCheck() {
    return userName == '' || userName.length < 2 || !nameRegexCheck() ? '정상적인 이름 형식이 아닙니다.' : null;
  }

  String? emailCheck() {
    return userEmail == '' || !emailRegexCheck() ? '정상적인 이메일 형식이 아닙니다.' : null;
  }

  String? phoneNumberCheck() {
    return userPhoneNumber == '' || !phoneNumberRegexCheck() ? '정상적인 휴대폰번호 형식이 아닙니다.' : null;
  }

  bool validationCheck() {
    if (!idRegexCheck()
      || !nameRegexCheck()
      || userBirthdayYear.trim().replaceAll('0', '').length != 4
      || userBirthdayMonth.trim().replaceAll('0', '').isEmpty
      || userBirthdayDay.trim().replaceAll('0', '').isEmpty) {
      return false;
    }

    return true;
  }
  
  registStatus() {
    userBirthday = DateTime.now().toString();
    userSex = 'male';
  }

  String getUserBirthday() {
    if (userBirthdayYear.length != 4 && userBirthdayMonth.length != 2 && userBirthdayDay.length != 2) {
      return DateTime.now().toString();
    }
    else {
      return '${userBirthdayYear.padLeft(4, '0')}-${userBirthdayMonth.padLeft(2, '0')}-${userBirthdayDay.padLeft(2, '0')}';
    }
  }

  void setUserBirthday() {
    userBirthdayYear = userBirthday.substring(0, 4);
    userBirthdayMonth = userBirthday.substring(5, 2);
    userBirthdayDay = userBirthday.substring(8, 2);
  }

  Future<ResponseData> isUserCheck() async {
    String address = '/userCheck';
    Map<String, dynamic> body = {
      'userName': userName,
      'userBirthday': getUserBirthday(),
      'userSex': userSex,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200 && responseData.body.isNotEmpty) {
      userId = responseData.body.toString();
    }

    return responseData;
  }

  Future<String> userRegist() async {
    String address = '/userRegist';
    Map<String, dynamic> body = {
      'userId': userId,
      'userPassword': sha512.convert(utf8.encode(userPassword)).toString(),
      'userName': userName,
      'userEmail': userEmail,
      'userPhoneNumber': userPhoneNumber,
      'userBirthday': userBirthday,
      'userSex': userSex,
    };
    
    ResponseData response = await AppCore.request(ServerType.POST, address, body, null);

    return response.body;
  }

  Future<bool> userUpdate() async {
    String address = '/userInfoUpdate';
    Map<String, dynamic> body = {
      'userId' : userId,
      'userEmail': userEmail,
      'userPhoneNumber': userPhoneNumber,
      'bankId': bankId,
      'bankAccountNumber' : bankAccountNumber,
    };
    
    ResponseData response = await AppCore.request(ServerType.POST, address, body, null);

    if (response.body == 'true') {
      AppCore.instance.setUser(this);
      return true;
    }
    else {
      return false;
    }
  }

  Future<String> userLogin(bool isPasswordEncode) async {
    String address = '/login';
    Map<String, dynamic> body = {
      'userId': userId,
      'userPassword': isPasswordEncode ? sha512.convert(utf8.encode(userPassword)).toString() : userPassword
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      var json = jsonDecode(responseData.body);
      if (AppCore.getJsonBool(json, 'logInIsSuccess')) {
        userName = AppCore.getJsonString(json, 'userName');
        userEmail = AppCore.getJsonString(json, 'userEmail');
        userPhoneNumber = AppCore.getJsonString(json, 'userPhoneNumber');
        userBirthday = AppCore.getJsonString(json, 'userBirthday');
        userSex = AppCore.getJsonString(json, 'userSex');
        bankId = AppCore.getJsonInt(json, 'bankId');
        bankName = AppCore.getJsonString(json, 'bankName');
        bankAccountNumber = AppCore.getJsonString(json, 'bankAccountNumber');
        isLoginSucess = true;
        isManager = AppCore.getJsonBool(json, 'isManager');

        // 그룹 조회
        address = '/getLoginUserGroupList';
        body = {
          'userId': userId,
        };

        responseData = await AppCore.request(ServerType.POST, address, body, null);

        if (responseData.statusCode == 200) {
          for (var jsonGroup in jsonDecode(responseData.body)) {
            Group group = Group();
            group.setData(jsonGroup);

            groupList.add(group);
          }
        }

        // 부서, 직책 조회
        address = '/getLoginUserDepartmentPositionList';
        body = {
          'userId': userId,
        };

        responseData = await AppCore.request(ServerType.POST, address, body, null);

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

        // 권한 조회
        address = '/getUserAuthList';
        body = {
          'userId': userId
        };

        responseData = await AppCore.request(ServerType.POST, address, body, null);

        if (responseData.statusCode == 200) {
          List<Auth> authList = <Auth>[];
          for (var jsonAuth in jsonDecode(responseData.body)) {
            Auth auth = Auth.fromJson(jsonAuth);
            auth.positionId = AppCore.getJsonInt(jsonAuth, 'positionId');
            authList.add(auth);
          }

          for (Department department in departmentList) {
            for (Position position in department.positionList) {
              position.positionAuthList.addAll(authList.where((element) => element.positionId == position.positionId));
            }
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
    Map<String, dynamic> body = {
      'userId': userId,
      'userName': userName,
      'userBirthday': getUserBirthday(),
      'userSex': userSex,
    };

    return await AppCore.request(ServerType.POST, address, body, null);
  }

  Future<ResponseData> userUpdatePassword() async {
    String address = '/userPasswordUpdate';
    Map<String, dynamic> body = {
      'userId': userId,
      'userPassword': sha512.convert(utf8.encode(userPassword)).toString(),
    };

    return await AppCore.request(ServerType.POST, address, body, null);
  }

  bool passwordAuthCheck(String password) {
    if (userPassword == sha512.convert(utf8.encode(password)).toString()) {
      return true;
    }
    
    return false;
  }

  List<Auth> getAuthList() {
    List<Auth> authList = <Auth>[];

    for (Department department in departmentList) {
      for (Position position in department.positionList) {
        for (Auth auth in position.positionAuthList) {
          if (auth.use && authList.firstWhereOrNull((element) => element.authId == auth.authId) == null) {
            authList.add(auth);
          }
        }
      }
    }

    return authList;
  }
}