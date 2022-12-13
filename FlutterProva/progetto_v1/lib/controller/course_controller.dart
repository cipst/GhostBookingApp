import 'package:get/get.dart';
import 'package:progetto_v1/db/course_helper.dart';
import 'package:progetto_v1/model/course.dart';

class CourseController extends GetxController {
  Rx<String?> errorText = null.obs;
  final List<Course> _courses = <Course>[].obs;

  void getAllTeachers() async {
    try {
      List<Course> coursesList = await CourseHelper.getAllCourses();
      int i = 0;
      for (Course t in coursesList) {
        _courses[i] = t;
      }
    } on Exception catch (e) {
      errorText.value = e.toString();
    }
  }

  Future<Course?> getCourse(String name) async {
    try {
      return await CourseHelper.getCourse(name);
    } on Exception catch (e) {
      errorText.value = e.toString();
      return null;
    }
  }
}
