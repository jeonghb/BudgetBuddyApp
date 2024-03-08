import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'calculate_mail.dart';
import 'receipt.dart';

class Mail {
  CalculateMail calculateMail = CalculateMail();

  Future<bool> sendCalculateMail() async {
    // 엑셀 생성
    Excel excel = Excel.createExcel();
    // excel.rename('Sheet1', '사용내역');

    Sheet sheet = excel['Sheet1'];

    // 컬럼명 입력
    sheet.merge(CellIndex.indexByString('B2'), CellIndex.indexByString('K2'), customValue: calculateMail.title);
    sheet.cell(CellIndex.indexByString('B2')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Center, bold: true, underline: Underline.Single);
    sheet.cell(CellIndex.indexByString('B3')).value = '번호';
    sheet.cell(CellIndex.indexByString('B3')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Center, backgroundColorHex: '#ffffcc', );
    sheet.cell(CellIndex.indexByString('C3')).value = '구분';
    sheet.cell(CellIndex.indexByString('C3')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Center, backgroundColorHex: '#ffffcc');
    sheet.cell(CellIndex.indexByString('D3')).value = '지출내역';
    sheet.cell(CellIndex.indexByString('D3')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Center, backgroundColorHex: '#ffffcc');
    sheet.cell(CellIndex.indexByString('E3')).value = '지출';
    sheet.cell(CellIndex.indexByString('E3')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Center, backgroundColorHex: '#ffffcc');
    sheet.cell(CellIndex.indexByString('F3')).value = '수익';
    sheet.cell(CellIndex.indexByString('F3')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Center, backgroundColorHex: '#ffffcc');
    sheet.cell(CellIndex.indexByString('G3')).value = '잔액';
    sheet.cell(CellIndex.indexByString('G3')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Center, backgroundColorHex: '#ffffcc');
    sheet.cell(CellIndex.indexByString('H3')).value = '결제자';
    sheet.cell(CellIndex.indexByString('H3')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Center, backgroundColorHex: '#ffffcc');
    sheet.cell(CellIndex.indexByString('I3')).value = '결제일자';
    sheet.cell(CellIndex.indexByString('I3')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Center, backgroundColorHex: '#ffffcc');
    sheet.cell(CellIndex.indexByString('J3')).value = '송금일자';
    sheet.cell(CellIndex.indexByString('J3')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Center, backgroundColorHex: '#ffffcc');
    sheet.cell(CellIndex.indexByString('K3')).value = '영수증';
    sheet.cell(CellIndex.indexByString('K3')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Center, backgroundColorHex: '#ffffcc');
    sheet.cell(CellIndex.indexByString('L3')).value = '계좌번호';
    sheet.cell(CellIndex.indexByString('L3')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Center, backgroundColorHex: '#ffffcc');
    
    // 데이터 입력
    int rowIndex = 4;
    int remainBudgetAmount = calculateMail.remainBudgetAmount;
    for (Receipt receipt in calculateMail.receiptList) {
      sheet.cell(CellIndex.indexByString('B$rowIndex')).value = rowIndex - 3;
      sheet.cell(CellIndex.indexByString('B$rowIndex')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Center);
      sheet.cell(CellIndex.indexByString('C$rowIndex')).value = receipt.budgetTypeName;
      sheet.cell(CellIndex.indexByString('C$rowIndex')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Center);
      sheet.cell(CellIndex.indexByString('D$rowIndex')).value = receipt.title;
      sheet.cell(CellIndex.indexByString('D$rowIndex')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Left);
      sheet.cell(CellIndex.indexByString('E$rowIndex')).value = receipt.approvalDatetime.isNotEmpty ? NumberFormat('#,##0', 'en-US').format(receipt.requestAmount) : '';
      sheet.cell(CellIndex.indexByString('E$rowIndex')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Right);
      sheet.cell(CellIndex.indexByString('F$rowIndex')).value = receipt.approvalDatetime.isEmpty ? NumberFormat('#,##0', 'en-US').format(receipt.requestAmount) : '';
      sheet.cell(CellIndex.indexByString('F$rowIndex')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Right);
      sheet.cell(CellIndex.indexByString('G$rowIndex')).value = receipt.approvalDatetime.isNotEmpty ? NumberFormat('#,##0', 'en-US').format(remainBudgetAmount - receipt.requestAmount) : NumberFormat('#,##0', 'en-US').format(remainBudgetAmount + receipt.requestAmount);
      sheet.cell(CellIndex.indexByString('G$rowIndex')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Right);
      sheet.cell(CellIndex.indexByString('H$rowIndex')).value = receipt.requestUserName;
      sheet.cell(CellIndex.indexByString('H$rowIndex')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Center);
      sheet.cell(CellIndex.indexByString('I$rowIndex')).value = receipt.paymentDatetime.isNotEmpty ? receipt.paymentDatetime.substring(0, 10) : '';
      sheet.cell(CellIndex.indexByString('I$rowIndex')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Center);
      sheet.cell(CellIndex.indexByString('J$rowIndex')).value = receipt.sendDatetime.isNotEmpty ? receipt.sendDatetime.substring(0, 10) : '';
      sheet.cell(CellIndex.indexByString('J$rowIndex')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Center);
      sheet.cell(CellIndex.indexByString('K$rowIndex')).value = receipt.fileNameList.isNotEmpty ? 'o' : '';
      sheet.cell(CellIndex.indexByString('K$rowIndex')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Center);
      sheet.cell(CellIndex.indexByString('L$rowIndex')).value = receipt.bankAccountNumber;
      sheet.cell(CellIndex.indexByString('L$rowIndex')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Center);

      remainBudgetAmount = receipt.approvalDatetime.isNotEmpty ? remainBudgetAmount - receipt.requestAmount : remainBudgetAmount + receipt.requestAmount;
      rowIndex++;
    }

    // 합계 입력
    sheet.cell(CellIndex.indexByString('E$rowIndex')).value = NumberFormat('#,##0', 'en-US').format(calculateMail.receiptList.map((e) => e.approvalDatetime.isNotEmpty ? e.requestAmount : 0).sum);
    sheet.cell(CellIndex.indexByString('E$rowIndex')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Right);
    sheet.cell(CellIndex.indexByString('F$rowIndex')).value = NumberFormat('#,##0', 'en-US').format(calculateMail.receiptList.map((e) => e.approvalDatetime.isNotEmpty ? 0 : e.requestAmount).sum);
    sheet.cell(CellIndex.indexByString('F$rowIndex')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Right);
    sheet.cell(CellIndex.indexByString('G$rowIndex')).value = NumberFormat('#,##0', 'en-US').format(remainBudgetAmount);
    sheet.cell(CellIndex.indexByString('G$rowIndex')).cellStyle = CellStyle(verticalAlign: VerticalAlign.Center, horizontalAlign: HorizontalAlign.Right);

    // 엑셀 저장
    var directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/${calculateMail.title}.xlsx';
    List<int>? excelByte = excel.encode();
    
    File(filePath).writeAsBytesSync(excelByte!);

    // 공유
    await Share.shareFiles([filePath], text: '엑셀 파일 공유');

    return true;
  }
}