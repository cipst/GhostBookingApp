import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progetto_v1/db/lesson_helper.dart';
import 'package:progetto_v1/model/lesson.dart';

class LessonController extends GetxController {
  final List<Lesson> lessons = <Lesson>[].obs;
  final Map<Lesson, bool> selectedLessons = <Lesson, bool>{}.obs;

  Future<List<Lesson>?> getAllLessons() async {
    try {
      lessons.clear();

      List<Lesson>? lessonsList = await LessonHelper.getAllLessons();
      if(lessonsList == null) return null;

      for (Lesson t in lessonsList) {
        lessons.add(t);
      }

      return lessonsList;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<Lesson?> getLesson(int id) async {
    try {
      return await LessonHelper.getLesson(id);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    } on Error catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<Lesson>?> getLessonsByDate(String dateTime) async {
    try {
      return await LessonHelper.getLessonsByDate(dateTime);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    } on Error catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<Lesson>?> getLessonsByCourse(String course) async {
    try {
      return await LessonHelper.getLessonsByCourse(course);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    } on Error catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<Lesson>?> getLessonsByTeacher(String teacher) async {
    try {
      return (await LessonHelper.getLessonsByTeacher(teacher));
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    } on Error catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
