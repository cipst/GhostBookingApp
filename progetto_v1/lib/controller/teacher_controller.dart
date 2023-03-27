import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progetto_v1/db/teacher_helper.dart';
import 'package:progetto_v1/model/teacher.dart';

class TeacherController extends GetxController {
  final errorText = "".obs;
  final List<Teacher> teachers = <Teacher>[].obs;

  Future<List<Teacher>?> getAllTeachers() async {
    try {
      teachers.clear();

      List<Teacher>? teachersList = await TeacherHelper.getAllTeachers();
      if(teachersList == null) return null;

      for (Teacher t in teachersList) {
        teachers.add(t);
      }
      return teachersList;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    } on Error catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
