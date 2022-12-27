import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:progetto_v1/db/lesson_helper.dart';
import 'package:progetto_v1/model/lesson.dart';

class LessonController extends GetxController {
  final errorText = "".obs;
  final List<Lesson> lessons = <Lesson>[].obs;

  void getAllLessons() async {
    try {
      lessons.clear();

      List<Lesson>? lessonsList = await LessonHelper.getAllLessons();
      if(lessonsList == null) return;

      for (Lesson t in lessonsList) {
        lessons.add(t);
      }
    } on Exception catch (e) {
      errorText.value = e.toString();
    }
  }

  void getLessons(DateTime dateTime) async {
    try {
      lessons.clear();

      List<Lesson>? lessonsList = await LessonHelper.getLessons(dateTime);
      if(lessonsList == null) return;

      for (Lesson t in lessonsList) {
        lessons.add(t);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      errorText.value = e.toString();
    } on Error catch (e) {
      errorText.value = e.toString();
    }
  }

  Future<Lesson?> getLesson(int id) async {
    try {
      return await LessonHelper.getLesson(id);
    } on Exception catch (e) {
      errorText.value = e.toString();
      return null;
    }
  }
}
