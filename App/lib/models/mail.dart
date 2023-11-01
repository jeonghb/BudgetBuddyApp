import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'calculate_mail.dart';
import 'receipt.dart';

class Mail {
  CalculateMail calculateMail = CalculateMail();

  Future<bool> sendCalculateMail() async {
    // 엑셀 생성
    Excel excel = Excel.createExcel();
    excel.rename('Sheet1', '사용내역');

    Sheet sheet = excel['사용내역'];

    // 엑셀에 정보 저장
    sheet.merge(CellIndex.indexByString('B2'), CellIndex.indexByString('K2'), customValue: '데이터 테스트');
    sheet.cell(CellIndex.indexByString('B3')).value = '번호';
    sheet.cell(CellIndex.indexByString('C3')).value = '구분';
    sheet.cell(CellIndex.indexByString('D3')).value = '지출내역';
    sheet.cell(CellIndex.indexByString('E3')).value = '지출';
    sheet.cell(CellIndex.indexByString('F3')).value = '수익';
    sheet.cell(CellIndex.indexByString('G3')).value = '잔액';
    sheet.cell(CellIndex.indexByString('H3')).value = '결제자';
    sheet.cell(CellIndex.indexByString('I3')).value = '결제일자';
    sheet.cell(CellIndex.indexByString('J3')).value = '송금일자';
    sheet.cell(CellIndex.indexByString('K3')).value = '영수증';
    
    int rowIndex = 4;
    for (Receipt receipt in calculateMail.receiptList) {
      sheet.cell(CellIndex.indexByString('B$rowIndex')).value = '$rowIndex';
      sheet.cell(CellIndex.indexByString('C$rowIndex')).value = receipt.budgetTypeName;
    }

    // 엑셀 저장
    var fileBytes = excel.save();
    var directory = await getApplicationDocumentsDirectory();

    File(join('${directory.path}/text.xlsx'))..createSync(recursive: true)..writeAsBytesSync(fileBytes!);

    // 공유
    Share.shareFiles([join('${directory.path}/text.xlsx')], text: '엑셀 파일 공유');
    
    // 메일 전송
    // Email email = Email(
    //   body: '',
    //   subject: '[월별 정산 메일]',
    //   recipients: [AppCore.instance.getUser().userEmail.text],
    //   attachmentPaths: [],
    // );

    // try {
    //   await FlutterEmailSender.send(email);
    // } catch (error) {
    //   return false;
    // }

    return true;
  }
}