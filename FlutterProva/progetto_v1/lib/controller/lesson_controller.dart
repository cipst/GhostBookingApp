import 'package:get/get.dart';
import 'package:progetto_v1/controller/error_controller.dart';
import 'package:progetto_v1/db/lesson_helper.dart';
import 'package:progetto_v1/model/lesson.dart';

class LessonController extends GetxController {
  final List<Lesson> lessons = <Lesson>[].obs;
  final Map<Lesson, bool> selectedLessons = <Lesson, bool>{}.obs;

  void getAllLessons() async {
    try {
      ErrorController.clear();
      lessons.clear();

      List<Lesson>? lessonsList = await LessonHelper.getAllLessons();
      if(lessonsList == null) return;

      for (Lesson t in lessonsList) {
        lessons.add(t);
      }
    } on Exception catch (e) {
      ErrorController.text.value = e.toString();
    }
  }

  Future<Lesson?> getLesson(int id) async {
    try {
      ErrorController.clear();
      return await LessonHelper.getLesson(id);
    } on Exception catch (e) {
      ErrorController.text.value = e.toString();
      return null;
    } on Error catch (e) {
      ErrorController.text.value = e.toString();
      return null;
    }
  }

  void getLessonsByDate(DateTime dateTime) async {
    try {
      ErrorController.clear();
      lessons.clear();

      List<Lesson>? lessonsList = await LessonHelper.getLessonsByDate(dateTime);
      if(lessonsList == null) return;

      for (Lesson t in lessonsList) {
        lessons.add(t);
      }
    } on Exception catch (e) {
      ErrorController.text.value = e.toString();
    } on Error catch (e) {
      ErrorController.text.value = e.toString();
    }
  }

  void getLessonsByCourse(String course) async {
    try {
      ErrorController.clear();
      lessons.clear();

      List<Lesson>? lessonsList = await LessonHelper.getLessonsByCourse(course);
      if(lessonsList == null) return;

      for (Lesson t in lessonsList) {
        lessons.add(t);
      }
    } on Exception catch (e) {
      ErrorController.text.value = e.toString();
    } on Error catch (e) {
      ErrorController.text.value = e.toString();
    }
  }

  void getLessonsByTeacher(String teacher) async {
    try {
      ErrorController.clear();
      lessons.clear();

      List<Lesson>? lessonsList = await LessonHelper.getLessonsByTeacher(teacher);
      if(lessonsList == null) return;

      for (Lesson t in lessonsList) {
        lessons.add(t);
      }
    } on Exception catch (e) {
      ErrorController.text.value = e.toString();
    } on Error catch (e) {
      ErrorController.text.value = e.toString();
    }
  }
}
