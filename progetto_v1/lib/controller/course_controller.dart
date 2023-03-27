import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progetto_v1/db/course_helper.dart';
import 'package:progetto_v1/model/course.dart';

class CourseController extends GetxController {
  final List<Course> courses = <Course>[].obs;

  Future<List<Course>?> getAllCourses() async {
    try {
      courses.clear();

      List<Course>? coursesList = await CourseHelper.getAllCourses();
      if(coursesList == null) return null;

      for (Course c in coursesList) {
        courses.add(c);
      }

      return coursesList;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    } on Error catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
