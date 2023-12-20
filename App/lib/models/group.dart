import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:test/app_core.dart';

import 'auth.dart';
import 'department.dart';
import 'position.dart';
import 'response_data.dart';

class Group {
  int groupId = -1;
  String groupName = '';
  String groupIntroduceMemo = '';
  int groupUserCount = -1;
  bool groupMaster = false;
  List<Department> departmentList = <Department>[];
  bool groupStatus = false;
  bool isManager = false;

  void setData(var json) {
    groupId = AppCore.getJsonInt(json, 'groupId');
    groupName = AppCore.getJsonString(json, 'groupName');
    groupIntroduceMemo = AppCore.getJsonString(json, 'groupIntroduceMemo');
    groupUserCount = AppCore.getJsonInt(json, 'groupUserCount');
    groupMaster = AppCore.getJsonBool(json, 'groupMaster');
    groupStatus = AppCore.getJsonBool(json, 'groupStatus');
    isManager = AppCore.getJsonBool(json, 'isManager');
  }

  Future<bool> groupAdd() async {
    String address = '/groupAdd';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId,
      'groupName': groupName,
      'groupIntroduceMemo': groupIntroduceMemo,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      var json = jsonDecode(responseData.body);
      if (AppCore.getJsonBool(json, 'success')) {
        setData(json);
        
        AppCore.instance.getUser().groupList.add(this);
        return true;
      }
      else {
        return false;
      }
    }
    else {
      return false;
    }
  }

  Future<bool> groupDelete() async {
    String address = '/groupDelete';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId,
      'groupId': groupId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      if (responseData.body.toString() == 'true') {
        AppCore.instance.getUser().groupList.remove(this);
        return true;
      }
      else {
        return false;
      }
    }
    else {
      return false;
    }
  }

  Future<bool> groupExit() async {
    String address = '/groupExit';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId,
      'groupId': groupId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      if (responseData.body.toString() == 'true') {
        AppCore.instance.getUser().groupList.remove(this);
        return true;
      }
      else {
        return false;
      }
    }
    else {
      return false;
    }
  }

  Future<void> getLoginUserDepartmentPositionList(String _userId) async {
    // 부서, 직책 조회
    String address = '/getLoginUserDepartmentPositionList';
    Map<String, dynamic> body = {
      'userId': _userId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

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
      'userId': _userId
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