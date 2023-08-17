import 'package:test/app_core.dart';

class Auth {
  String authId = '';
  String authName = '';
  bool use = false;

  Auth({
    required this.authId,
    required this.authName,
    required this.use,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      authId: AppCore.getJsonString(json, 'authId'),
      authName: AppCore.getJsonString(json, 'authName'),
      use: AppCore.getJsonBool(json, 'use'),
    );
  }

  void setData(var json) {
    authId = AppCore.getJsonString(json, 'authId');
    authName = AppCore.getJsonString(json, 'authName');
    use = AppCore.getJsonBool(json, 'use');
  }
}