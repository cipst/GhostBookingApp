import 'package:get/get.dart';
import 'package:progetto_v1/db/teacher_helper.dart';
import 'package:progetto_v1/model/teacher.dart';

class TeacherController extends GetxController {
  Rx<String?> errorText = null.obs;
  final List<Teacher> _teachers = <Teacher>[].obs;

  void getAllTeachers() async {
    try {
      List<Teacher> teachersList = await TeacherHelper.getAllTeachers();
      int i = 0;
      for (Teacher t in teachersList) {
        _teachers[i] = t;
      }
    } on Exception catch (e) {
      errorText.value = e.toString();
    }
  }

  Future<Teacher?> getTeacher(String name) async {
    try {
      return await TeacherHelper.getTeacher(name);
    } on Exception catch (e) {
      errorText.value = e.toString();
      return null;
    }
  }
}
