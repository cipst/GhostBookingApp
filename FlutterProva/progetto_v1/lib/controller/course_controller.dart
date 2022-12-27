import 'package:get/get.dart';
import 'package:progetto_v1/db/course_helper.dart';
import 'package:progetto_v1/model/course.dart';

class CourseController extends GetxController {
  final errorText = "".obs;
  final List<Course> courses = <Course>[].obs;

  void getAllCourses() async {
    try {
      courses.clear();

      List<Course>? coursesList = await CourseHelper.getAllCourses();
      if(coursesList == null) return;

      for (Course c in coursesList) {
        courses.add(c);
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
