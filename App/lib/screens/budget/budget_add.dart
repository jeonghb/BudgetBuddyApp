// import 'package:flutter/material.dart';
// import '../widgets/top_bar.dart';

// class BudgetAdd extends StatefulWidget {
//   const BudgetAdd({super.key});

//   @override
//   State<BudgetAdd> createState() => _BudgetAdd();
// }

// class _BudgetAdd extends State<BudgetAdd> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => { FocusScope.of(context).unfocus()},
//       child: Scaffold(
//         appBar: TopBar(),
//         endDrawer: MenuDrawer(),
//         backgroundColor: Colors.white,
//         body: Center(
//           child: Padding(
//             padding: EdgeInsets.all(30),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text('제목',
//                     style: TextStyle(
//                       fontSize: 20
//                     ),
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
//                       ),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         borderSide: BorderSide(color: Colors.red)
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         borderSide: BorderSide(color: Colors.red)
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                     autofocus: true,
//                     keyboardType: TextInputType.text,
//                     controller: receipt.title,
//                     textInputAction: TextInputAction.next,
//                   ),
//                   Text('금액',
//                     style: TextStyle(
//                       fontSize: 20
//                     ),
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
//                       ),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         borderSide: BorderSide(color: Colors.red)
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         borderSide: BorderSide(color: Colors.red)
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                     autofocus: true,
//                     autovalidateMode: AutovalidateMode.always,
//                     keyboardType: TextInputType.number,
//                     controller: receipt.requestAmount,
//                     textInputAction: TextInputAction.next,
//                   ),
//                   Text('메모',
//                     style: TextStyle(
//                       fontSize: 20
//                     ),
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
//                       ),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         borderSide: BorderSide(color: Colors.red)
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         borderSide: BorderSide(color: Colors.red)
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                     autofocus: true,
//                     autovalidateMode: AutovalidateMode.always,
//                     keyboardType: TextInputType.name,
//                     controller: receipt.memo,
//                     textInputAction: TextInputAction.next,
//                   ),
//                   Text('신청부서',
//                     style: TextStyle(
//                       fontSize: 20
//                     ),
//                   ),
//                   Container(
//                     width: 80,
//                     height: 40,
//                     child: DropdownButton(
//                       value: receipt.approvalRequestDepartmentName,
//                       items: departmentList.map(
//                         (value) { 
//                           return DropdownMenuItem<String>(
//                             value: value.department_name,
//                             child: Text(value.department_name),
//                             );
//                           },
//                         ).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           receipt.approvalRequestDepartmentId = departmentList.firstWhere((element) => element.department_name == value).department_id;
//                           receipt.approvalRequestDepartmentName = departmentList.firstWhere((element) => element.department_name == value).department_name;
//                         });
//                       }
//                     ),
//                   ),
//                   SizedBox(
//                     height: 12,
//                   ),
//                   TextButton(
//                     onPressed: () async {
//                       if (await receipt.save()) {
//                         // ignore: use_build_context_synchronously
//                         showDialog(
//                           context: context, 
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                               title: Column(children: <Widget>[Text('영수증 제출')]),
//                               content: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[Text("제출 완료",),],
//                               ),
//                               actions: <Widget>[
//                                 TextButton(
//                                   child: Text('확인'), 
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                     Navigator.pop(context);
//                                   },
//                                 )
//                               ],
//                             );
//                           },
//                         );
//                       }
//                     },
//                     child: Text('제출')
//                   ),
//                 ]
//               )
//             )
//           )
//         )
//       )
//     );
//   }
// }