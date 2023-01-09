import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progetto_v1/controller/course_controller.dart';
import 'package:progetto_v1/controller/error_controller.dart';
import 'package:progetto_v1/controller/lesson_controller.dart';
import 'package:progetto_v1/controller/teacher_controller.dart';
import 'package:progetto_v1/ui/components/search_stepper.dart';
import 'package:progetto_v1/ui/pages/summary_lessons_page.dart';
import 'package:progetto_v1/utils/app_layout.dart';
import 'package:progetto_v1/utils/app_style.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  LessonController lessonController = Get.put(LessonController());
  TeacherController teacherController = Get.put(TeacherController());
  CourseController courseController = Get.put(CourseController());

  @override
  void initState(){
    lessonController.getAllLessons();
    teacherController.getAllTeachers();
    courseController.getAllCourses();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          CustomScrollView(
            slivers: [
              if(ErrorController.text.value != "")
                SliverToBoxAdapter(
                    child: Center(
                      child: Obx(() => Text(ErrorController.text.value)),
                    )
                ),

              const SliverToBoxAdapter(
                child: SearchStepper(),
              ),

              SliverToBoxAdapter(
                child: Gap(AppLayout.initNavigationBarHeight + 35),
              )
            ],
          ),

          // FLOATING ACTION BUTTON WHEN AT LEAST ONE LESSON IS SELECTED
          Obx(() {
            if (!lessonController.selectedLessons.containsValue(true)) {
              return Container();
            }

            return Positioned(
              bottom: AppLayout.initNavigationBarHeight + 10,
              child: SizedBox(
                width: AppLayout
                    .getSize(context)
                    .width,
                child: Center(
                  child: FittedBox(
                    child: Stack(
                      alignment: const Alignment(1.2, -1.5),
                      children: [
                        FloatingActionButton.extended(
                          onPressed: () => Get.to(() => const SummaryLessons()),
                          label: Row(
                            children: const [
                              Icon(Ionicons.albums_outline),
                              // Gap(8),
                              // Text("Summary"),
                            ],
                          ),
                        ),

                        //BADGE
                        Container(
                          padding: const EdgeInsets.all(4),
                          constraints: const BoxConstraints(minHeight: 24,
                              minWidth: 24),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    color: Colors.black.withAlpha(50))
                              ],
                              borderRadius: BorderRadius.circular(16),
                              color: Styles.blueColor
                          ),
                          child: Center(
                            child: Text(
                                "${lessonController.selectedLessons.values
                                    .where((b) => b == true)
                                    .length}",
                                style: const TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ]
    );
  }
}
