import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';

class AppCore {
  static String baseUrl = "http://211.197.27.23:8081";
  static String localUrl = "http://192.168.0.2:8081";
  static AppCore instance = AppCore();
  static User user = User();

  static AppCore getInstance() {
    return instance;
  }

  void setUser(User _user) {
    user = _user;
  }

  User getUser() {
    return user;
  }

  Future<User> getUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool('autoLogin') != null && preferences.getBool('autoLogin')!) {
      User localUserInfo = User();
      localUserInfo.userId.text = preferences.getString('userId')!;
      localUserInfo.userPassword.text = preferences.getString('userPassword')!;

      String result = await localUserInfo.userLogin(false);
      if (result == "0") {
        setUser(localUserInfo);
      }
    }

    return getUser();
  }

  Future<void> logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setBool('autoLogin', false);
    preferences.setString('userId', '');
    preferences.setString('userPassword', '');

    User initializeUser = User();
    setUser(initializeUser);
  }
}