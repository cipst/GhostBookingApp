import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progetto_v1/controller/lesson_controller.dart';
import 'package:progetto_v1/model/lesson.dart';
import 'package:progetto_v1/utils/app_layout.dart';
import 'package:progetto_v1/utils/app_style.dart';

class SummaryLessons extends StatefulWidget {
  const SummaryLessons({Key? key}) : super(key: key);

  @override
  State<SummaryLessons> createState() => _SummaryLessonsState();
}

class _SummaryLessonsState extends State<SummaryLessons> {
  final LessonController lessonController = Get.put(LessonController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Styles.errorColor),
                    maximumSize: MaterialStatePropertyAll(Size.fromWidth(AppLayout.getSize(context).width/3)),
                  ),
                  onPressed: (){
                    lessonController.selectedLessons.clear();
                    Get.back();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Text("Delete all"),
                      ),
                      Gap(8),
                      Icon(Ionicons.trash_outline),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Obx(() => ListView.builder(
                  itemCount: lessonController.selectedLessons.length,
                  itemBuilder: (context, index) {
                    Lesson lesson = lessonController.selectedLessons.keys.elementAt(index);
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Styles.blueColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DefaultTextStyle(
                        style: const TextStyle(color: Colors.white),
                        child: Column(
                          children: [
                            Text(lesson.teacher.name),
                            Text(lesson.course.name),
                            Text(DateFormat.MMMMd().format(lesson.dateTime)),
                            Text(DateFormat.Hm().format(lesson.dateTime)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                ),
              )
            ])
    );
  }
}
