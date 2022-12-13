import 'package:get/get.dart';
import 'package:progetto_v1/db/lesson_helper.dart';
import 'package:progetto_v1/model/lesson.dart';

class LessonController extends GetxController {
  Rx<String?> errorText = null.obs;
  final List<Lesson> _lessons = <Lesson>[].obs;

  void getAllLessons() async {
    try {
      List<Lesson> lessonsList = await LessonHelper.getAllLessons();
      int i = 0;
      for (Lesson t in lessonsList) {
        _lessons[i] = t;
      }
    } on Exception catch (e) {
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
