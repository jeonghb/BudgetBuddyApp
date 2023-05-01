import 'package:flutter/material.dart';

class BillData with ChangeNotifier {
  TextEditingController requestId = TextEditingController();
  TextEditingController registDateTime = TextEditingController();
  TextEditingController requestAmount = TextEditingController();
  TextEditingController memberList = TextEditingController();
  TextEditingController fileName = TextEditingController();
  TextEditingController paymentDateTime = TextEditingController();
  TextEditingController memo = TextEditingController();
  TextEditingController departmentType = TextEditingController();
  TextEditingController approvalType = TextEditingController();
  TextEditingController approvalDatetime = TextEditingController();
  TextEditingController calculateStatus = TextEditingController();
  TextEditingController calculateDateTime = TextEditingController();
}