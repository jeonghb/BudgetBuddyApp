import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test/widgets/text_form_field_v1.dart';
import '../../widgets/title_text.dart';
import '../screen_frame.dart';
import '../../app_core.dart';
import '../../models/department_member.dart';
import '../../models/response_data.dart';
import 'department_member_manage.dart';

class DepartmentMemberList extends StatefulWidget {
  const DepartmentMemberList({super.key});

  @override
  State<DepartmentMemberList> createState() => _DepartmentMemberList();
}

class _DepartmentMemberList extends State<DepartmentMemberList> {
  List<DepartmentMember> departmentMemberList = <DepartmentMember>[];
  List<DepartmentMember> departmentMemberFilterList = <DepartmentMember>[];
  TextEditingController searchText = TextEditingController();
  SortType sortType = SortType.alphabetAsc;

  @override
  void initState() {
    super.initState();

    getDepartmentMemberList();
  }
  
  Future<void> getDepartmentMemberList() async {
    String address = '/getDepartmentMemberList';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200 && responseData.body.isNotEmpty) {
      List<DepartmentMember> tempList = <DepartmentMember>[];

      for (var json in jsonDecode(responseData.body)) {
        DepartmentMember departmentMember = DepartmentMember();
        departmentMember.setData(json);
        tempList.add(departmentMember);
      }

      setState(() {
        departmentMemberList = tempList;
        departmentMemberFilterList = tempList;
      });
    }
  }

  void filterDepartmentMemberList() {
    setState(() {
      departmentMemberFilterList = departmentMemberList.where((element) => element.userName.contains(searchText.text)).toList();
    });
  }

  void sortDepartmentMemeberList(SortType updateSortType) {
    setState(() {
      sortType = updateSortType;
    });

    switch (updateSortType) {
      case SortType.alphabetAsc:
        setState(() {
          departmentMemberFilterList.sort(((a, b) => a.userName.compareTo(b.userName)));
        });
      break;
      case SortType.alphabetDesc:
        setState(() {
          departmentMemberFilterList.sort(((a, b) => b.userName.compareTo(a.userName)));
        });
      break;
      case SortType.registAsc:
        setState(() {
          departmentMemberFilterList.sort(((a, b) => a.userDepartmentRegistDatetime.compareTo(b.userDepartmentRegistDatetime)));
        });
      break;
      case SortType.registDesc:
        setState(() {
          departmentMemberFilterList.sort(((a, b) => b.userDepartmentRegistDatetime.compareTo(a.userDepartmentRegistDatetime)));
        });
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: '부서원 목록',
            ),
            TextFormFieldV1(
              controller: searchText,
              onEditingComplete: () {
                filterDepartmentMemberList();
                FocusScope.of(context).dispose();
              },
              suffixIcon: Icon(Icons.search),
              textInputAction: TextInputAction.search,
              autofocus: false,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      if (sortType == SortType.alphabetAsc) {
                        sortDepartmentMemeberList(SortType.alphabetDesc);
                      }
                      else {
                        sortDepartmentMemeberList(SortType.alphabetAsc);
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      backgroundColor: sortType == SortType.alphabetAsc || sortType == SortType.alphabetDesc ? Colors.black : Colors.grey[300],
                    ),
                    child: Text(
                      '가나다순',
                      style: TextStyle(
                        fontSize: 14,
                        color: sortType == SortType.alphabetAsc || sortType == SortType.alphabetDesc ? Colors.white : Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      if (sortType == SortType.registAsc) {
                        sortDepartmentMemeberList(SortType.registDesc);
                      }
                      else {
                        sortDepartmentMemeberList(SortType.registAsc);
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      backgroundColor: sortType == SortType.registAsc || sortType == SortType.registDesc ? Colors.black : Colors.grey[300],
                    ),
                    child: Text(
                      '등록순',
                      style: TextStyle(
                        fontSize: 14,
                        color: sortType == SortType.registAsc || sortType == SortType.registDesc ? Colors.white : Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: departmentMemberFilterList.length,
                itemBuilder: (BuildContext context, int index) {
                  final departmentMember = departmentMemberFilterList[index];

                  return GestureDetector(
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentMemberManage(departmentMember: departmentMember,)),);
                      getDepartmentMemberList();
                    },
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color.fromARGB(31, 0, 0, 0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          departmentMember.userName,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          departmentMember.userBirthday,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(2, 10, 2, 10),
                                          padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            color: Color.fromARGB(236, 214, 215, 252),
                                          ),
                                          child: Text(
                                            departmentMember.userPositionName.isNotEmpty ? departmentMember.userPositionName : '없음',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    )
                  );
                }
              ),
            ),
          ],
        )
      )
    );
  }
}

enum SortType {
  alphabetAsc,
  alphabetDesc,
  registAsc,
  registDesc
}