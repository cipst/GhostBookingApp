import 'package:get/get.dart';
import 'package:progetto_v1/db/user_helper.dart';
import 'package:progetto_v1/model/user.dart';

class UserController extends GetxController {
  Rx<String?> errorText = null.obs;
  late Rx<User> _user;

  void getUser(String email, String password) async {
    try {
      User u = await UserHelper.getUser(email, password);
      _user.value = u;
    } on Exception catch (e) {
      errorText.value = e.toString();
    }
  }
}
