import 'dart:typed_data';

class ResponseData {
  late int statusCode = 0;
  late String errorMessage = '';
  late String body = '';
  late Uint8List bodyBytes;
}