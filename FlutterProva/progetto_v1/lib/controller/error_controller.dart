import 'package:get/get.dart';

class ErrorController extends GetxController{
  static final text = "".obs;

  static clear() => text.value = "";
}