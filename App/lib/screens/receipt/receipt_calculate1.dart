import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/app_core.dart';
import 'package:test/screens/screen_frame.dart';
import 'package:test/widgets/title_text.dart';
import '../../models/response_data.dart';
import 'receipt_calculate2.dart';

class ReceiptCalculate1 extends StatefulWidget {
  const ReceiptCalculate1({super.key,});

  @override
  State<ReceiptCalculate1> createState() => _ReceiptCalculate1();
}

class _ReceiptCalculate1 extends State<ReceiptCalculate1> {
  int selectDepartmentId = AppCore.instance.getUser().departmentList.isNotEmpty ? AppCore.instance.getUser().departmentList[0].departmentId : -1;
  String selectDepartmentName = AppCore.instance.getUser().departmentList.isNotEmpty ? AppCore.instance.getUser().departmentList[0].departmentName : '';
  DateTime selectDate = DateTime.now();
  bool selectMonthIsDBData = false;

  @override
  void initState() {
    super.initState();

    getMonthCalculateStatus();
  }

  Future<void> selectCalendar(BuildContext context) async {
    final DateTime? picked = (await showDatePicker(
      context: context,
      initialDate: selectDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2050),
    ));
    
    if (picked != null && '${picked.year}-${picked.month}' != '${selectDate.year}-${selectDate.month}') {
      setState(() {
        selectDate = picked;
      });

      await getMonthCalculateStatus();
    }
  }

  Future<void> getMonthCalculateStatus() async {
    String address = '/getMonthCalculateStatus';
    Map<String, dynamic> body = {
      'departmentId': selectDepartmentId,
      'yearMonth': '${selectDate.year}-${selectDate.month.toString().padLeft(2, '0')}',
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200 && responseData.body.isNotEmpty) {
      setState(() {
        selectMonthIsDBData = responseData.body.toString() == 'true' ? true : false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TitleText(
              text: '월별 정산',
            ),
            Text(
              '정산 부서',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
              isExpanded: true,
              value: selectDepartmentName,
              items: AppCore.instance.getUser().departmentList.map(
                (value) { 
                  return DropdownMenuItem<String>(
                    value: value.departmentName,
                    child: Text(value.departmentName),
                    );
                  },
                ).toList(),
              onChanged: (value) {
                setState(() {
                  selectDepartmentId = AppCore.instance.getUser().departmentList.firstWhere((department) => department.departmentName == value).departmentId;
                  selectDepartmentName = AppCore.instance.getUser().departmentList.firstWhere((department) => department.departmentName == value).departmentName;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15),),
                  borderSide: BorderSide(
                    color: Colors.black26,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.fromLTRB(10, 1, 1, 1),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '정산 월 선택',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                selectCalendar(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${selectDate.year}-${selectDate.month.toString().padLeft(2, '0')}',
                  ),
                ],
              )
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                selectMonthIsDBData ? '정산 완료' : '정산 미완료',
                style: TextStyle(
                  color: selectMonthIsDBData ? Colors.blue : Colors.red,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(130),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 90, 68, 223),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptCalculate2(
                    departmentId: selectDepartmentId,
                    selectDate: selectDate,
                    isDBData: selectMonthIsDBData,
                  )));
                },
                child: Text(
                  '다음',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ]
        )
      )
    );
  }
}