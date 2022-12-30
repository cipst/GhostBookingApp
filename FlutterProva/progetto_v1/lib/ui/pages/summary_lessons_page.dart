import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progetto_v1/controller/lesson_controller.dart';
import 'package:progetto_v1/controller/navigation_controller.dart';
import 'package:progetto_v1/main.dart';
import 'package:progetto_v1/model/lesson.dart';
import 'package:progetto_v1/ui/pages/home_page.dart';
import 'package:progetto_v1/ui/pages/search_page.dart';
import 'package:progetto_v1/utils/app_layout.dart';
import 'package:progetto_v1/utils/app_style.dart';

class SummaryLessons extends StatefulWidget {
  const SummaryLessons({Key? key}) : super(key: key);

  @override
  State<SummaryLessons> createState() => _SummaryLessonsState();
}

class _SummaryLessonsState extends State<SummaryLessons> {
  final LessonController lessonController = Get.put(LessonController());
  final NavigationController navigationController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.bgColor,
        appBar: AppBar(
          title: const Text("Booking summary"),
        ),
        body: Column(
            children: [
              Expanded(
                child: Obx(() => ListView.builder(
                  itemCount: lessonController.selectedLessons.entries.where((m) => m.value == true).length,
                  itemBuilder: (context, index) {
                    Lesson lesson = lessonController.selectedLessons.entries.elementAt(index).key;
                    return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                        padding: const EdgeInsets.only(left: 24.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Styles.blueColor)
                        ),
                        child: DefaultTextStyle(
                          style: Styles.headLineStyle3.copyWith(color: Styles.textColor),
                          child: Row(
                              children: [
                                // Info
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Teacher name + Course name
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Ionicons.person_outline, size: 20.0, color: Styles.blueColor,),
                                            const Gap(8.0),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 2.0),
                                              child: Text(lesson.teacher.name),
                                            )
                                          ],
                                        ),
                                        const Gap(8.0),
                                        Row(
                                          children: [
                                            Icon(Ionicons.book_outline, size: 20.0, color: Styles.blueColor,),
                                            const Gap(8.0),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 2.0),
                                              child: Text(lesson.course.name),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),

                                    const Gap(32.0),

                                    // Date + time
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Ionicons.calendar_outline, size: 20.0, color: Styles.blueColor,),
                                            const Gap(8.0),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 2.0),
                                              child: Text(DateFormat.MMMMd().format(lesson.dateTime)),
                                            )
                                          ],
                                        ),
                                        const Gap(8.0),
                                        Row(
                                          children: [
                                            Icon(Ionicons.time_outline, size: 20.0, color: Styles.blueColor,),
                                            const Gap(8.0),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 2.0),
                                              child: Text(DateFormat.Hm().format(lesson.dateTime)),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // Delete button
                                Expanded(
                                  child: GestureDetector(
                                      onTap: (){
                                        lessonController.selectedLessons.removeWhere((key, value) => key == lesson);
                                        debugPrint(lessonController.selectedLessons.entries.where((m) => m.value == true).isEmpty.toString());

                                        if(lessonController.selectedLessons.entries.where((m) => m.value == true).isEmpty) {
                                          Get.back();
                                          Get.snackbar("No more lessons to book", "You have no more lessons to book, try to find others");
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 25),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.transparent),
                                        ),


                                        child: Icon(Ionicons.close, color: Styles.errorColor,),
                                      )
                                  ),
                                ),
                              ]
                          ),
                        )
                    );
                  },
                ),
                ),
              ),

              // BUTTONS
              Container(
                decoration: BoxDecoration(
                  color: Styles.bgColor,
                  boxShadow: const[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 7,
                      offset: Offset(0, 0), // Shadow position
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Styles.errorColor),
                          maximumSize: MaterialStatePropertyAll(Size.fromWidth(AppLayout.getSize(context).width/3)),
                        ),
                        onPressed: (){
                          lessonController.selectedLessons.clear();
                          Get.back();
                          Get.snackbar("All booked lessons canceled", "You have canceled all your booked lessons, try to find more");
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
                    const Gap(24),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Styles.successColor),
                          maximumSize: MaterialStatePropertyAll(Size.fromWidth(AppLayout.getSize(context).width/3)),
                        ),
                        onPressed: (){
                          // TODO: DB call to set the selected lessons as booked

                          // TODO: Remove the selected lessons from the selectedLesson Map

                          // TODO: When go back RECALL getLessons by date

                          Get.back();
                          navigationController.currentIndex = Pages.home;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 2.0),
                              child: Text("Book"),
                            ),
                            Gap(8),
                            Icon(Ionicons.checkmark),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ])
    );
  }
}
