import 'package:get/get.dart';
import 'package:progetto_v1/controller/error_controller.dart';
import 'package:progetto_v1/db/lesson_helper.dart';
import 'package:progetto_v1/model/lesson.dart';

class LessonController extends GetxController {
  final List<Lesson> lessons = <Lesson>[].obs;
  final Map<Lesson, bool> selectedLessons = <Lesson, bool>{}.obs;

  Future<List<Lesson>?> getAllLessons() async {
    try {
      ErrorController.clear();
      lessons.clear();

      List<Lesson>? lessonsList = await LessonHelper.getAllLessons();
      if(lessonsList == null) return null;

      for (Lesson t in lessonsList) {
        lessons.add(t);
      }

      return lessonsList;
    } on Exception catch (e) {
      ErrorController.text.value = e.toString();
      return null;
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

  Future<List<Lesson>?> getLessonsByDate(String dateTime) async {
    try {
      ErrorController.clear();
      return await LessonHelper.getLessonsByDate(dateTime);
    } on Exception catch (e) {
      ErrorController.text.value = e.toString();
      return null;
    } on Error catch (e) {
      ErrorController.text.value = e.toString();
      return null;
    }
  }

  Future<List<Lesson>?> getLessonsByCourse(String course) async {
    try {
      ErrorController.clear();
      return await LessonHelper.getLessonsByCourse(course);
    } on Exception catch (e) {
      ErrorController.text.value = e.toString();
      return null;
    } on Error catch (e) {
      ErrorController.text.value = e.toString();
      return null;
    }
  }

  Future<List<Lesson>?> getLessonsByTeacher(String teacher) async {
    try {
      ErrorController.clear();
      return (await LessonHelper.getLessonsByTeacher(teacher));
    } on Exception catch (e) {
      ErrorController.text.value = e.toString();
      return null;
    } on Error catch (e) {
      ErrorController.text.value = e.toString();
      return null;
    }
  }
}
