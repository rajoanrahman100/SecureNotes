import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static saveUserName(String userName) {
    return GetStorage().write("userName", userName);
  }

  static getUserName() {
    return GetStorage().read("userName");
  }

  static savePhotoUrl(String photoUrl) {
    return GetStorage().write("photoUrl", photoUrl);
  }

  static getPhotoUrl() {
    return GetStorage().read("photoUrl");
  }
}