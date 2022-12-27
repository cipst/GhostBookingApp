import 'package:get/get.dart';
import 'package:progetto_v1/db/teacher_helper.dart';
import 'package:progetto_v1/model/teacher.dart';

class TeacherController extends GetxController {
  final errorText = "".obs;
  final List<Teacher> teachers = <Teacher>[].obs;

  void getAllTeachers() async {
    try {
      teachers.clear();

      List<Teacher>? teachersList = await TeacherHelper.getAllTeachers();
      if(teachersList == null) return;

      for (Teacher t in teachersList) {
        teachers.add(t);
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
