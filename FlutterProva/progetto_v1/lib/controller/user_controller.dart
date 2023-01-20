import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progetto_v1/db/user_helper.dart';
import 'package:progetto_v1/model/user.dart';

class UserController extends GetxController {
  final user = Rxn<User>();

  void login(String email, String password) async {
    try {
      User? u = await UserHelper.getUser(email, password);
      if(u == null){
        Get.snackbar("Wrong credentials", "Email or password are wrong, retry!");
      }else{
        Get.snackbar("Good credentials", "${u.name} - ${u.email}");
      }
      user.value = u;
    } on Exception catch (e) {
      debugPrint(e.toString());
    } on Error catch (e) {
      debugPrint(e.toString());
    }
  }

  void logout() => user.value = null;

  void updateImage(String imageName) async {
    try{
      await UserHelper.updateImage(user.value!.email, imageName);
    }on Exception catch(e){
      debugPrint(e.toString());
    } on Error catch (e) {
      debugPrint(e.toString());
    }
  }
}
