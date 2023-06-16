import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:test/app_core.dart';

class File {
  String fileId = '';
  String fileName = '';
  String filePath = '';
  List<XFile> fileList = [];

  Future<String> fileSave() async {
    Uri uri = Uri.parse(AppCore.baseUrl + '/fileSave');

    http.Response response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'fileName': fileName,
        'filePath': filePath, 
        'fileList': fileList, 
        })
    );
    
    if (response.statusCode == 200) {
      return '0';
    }
    else {
      return '1';
    }
  }
}