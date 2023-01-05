import 'package:get/get.dart';
import 'package:progetto_v1/controller/error_controller.dart';
import 'package:progetto_v1/db/course_helper.dart';
import 'package:progetto_v1/model/course.dart';

class CourseController extends GetxController {
  final List<Course> courses = <Course>[].obs;

  void getAllCourses() async {
    try {
      ErrorController.clear();
      courses.clear();

      List<Course>? coursesList = await CourseHelper.getAllCourses();
      if(coursesList == null) return;

      for (Course c in coursesList) {
        courses.add(c);
      }
    } on Exception catch (e) {
      ErrorController.text.value = e.toString();
    } on Error catch (e) {
      ErrorController.text.value = e.toString();
    }
  }
}
