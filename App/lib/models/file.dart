import 'package:image_picker/image_picker.dart';
import 'package:test/app_core.dart';
import 'package:test/models/response_data.dart';

class File {
  String fileId = '';
  String fileName = '';
  String filePath = '';
  List<XFile> fileList = [];

  Future<String> fileSave() async {
    String address = '/fileSave';
    Map<String, dynamic> body = {
      'fileName': fileName,
      'filePath': filePath, 
      'fileList': fileList, 
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200) {
      return '0';
    }
    else {
      return '1';
    }
  }
}