import 'package:get/get.dart';
import 'package:progetto_v1/controller/error_controller.dart';
import 'package:progetto_v1/db/course_helper.dart';
import 'package:progetto_v1/model/course.dart';

class CourseController extends GetxController {
  final List<Course> courses = <Course>[].obs;

  Future<List<Course>?> getAllCourses() async {
    try {
      ErrorController.clear();
      courses.clear();

      List<Course>? coursesList = await CourseHelper.getAllCourses();
      if(coursesList == null) return null;

      for (Course c in coursesList) {
        courses.add(c);
      }

      return coursesList;
    } on Exception catch (e) {
      ErrorController.text.value = e.toString();
      return null;
    } on Error catch (e) {
      ErrorController.text.value = e.toString();
      return null;
    }
  }
}
