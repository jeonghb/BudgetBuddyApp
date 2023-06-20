import 'package:flutter/material.dart';

class Department with ChangeNotifier {
  String department_id = '';
  String department_name = '';
  bool activation_status = true;

  void setData(var _json) {
    department_id = _json['departmentId'];
    department_name = _json['departmentName'];
    activation_status = _json['activationStatus'] == 1 ? true : false;
  }
}