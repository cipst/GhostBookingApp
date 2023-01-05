import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progetto_v1/controller/course_controller.dart';
import 'package:progetto_v1/controller/error_controller.dart';
import 'package:progetto_v1/controller/lesson_controller.dart';
import 'package:progetto_v1/controller/teacher_controller.dart';
import 'package:progetto_v1/model/lesson.dart';
import 'package:progetto_v1/ui/components/card_search.dart';
import 'package:progetto_v1/ui/components/empty_data.dart';
import 'package:progetto_v1/ui/pages/summary_lessons_page.dart';
import 'package:progetto_v1/utils/app_layout.dart';
import 'package:progetto_v1/utils/app_style.dart';

enum CatalogType { date, teacher, subject }

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  CatalogType _currentCatalog = CatalogType.date;
  DateTime _selectedDate = DateTime(2023, 01, 09);

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

  set currentCatalog(CatalogType newCatalog) {
    setState(() {
      _currentCatalog = newCatalog;
    });
  }

  bool isCurrentCatalog(CatalogType checkCatalog) {
    return _currentCatalog == checkCatalog;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children:[
          CustomScrollView(
            slivers: [
              SliverAppBar(
                title: _catalogTabBar(),
                backgroundColor: Styles.bgColor,
                shadowColor: Colors.transparent,
                snap: true,
                floating: true,
              ),
              if(ErrorController.text.value != "")
                SliverToBoxAdapter(
                    child: Center(
                      child: Obx(() => Text(ErrorController.text.value)),
                    )
                ),

              if (isCurrentCatalog(CatalogType.date))
                SliverAppBar(
                  title: _datePicker(),
                  centerTitle: true,
                  toolbarHeight: 100,
                  backgroundColor: Styles.bgColor,
                  pinned: true,
                ),

              Obx(() =>
                  _catalogList(),
              ),

              SliverToBoxAdapter(
                child: Gap(AppLayout.initNavigationBarHeight + 35),
              )
            ],
          ),

          // FLOATING ACTION BUTTON WHEN AT LEAST ONE LESSON IS SELECTED
          // ONLY ON DATE TAB BAR
          if(isCurrentCatalog(CatalogType.date))
            Obx((){
              if(!lessonController.selectedLessons.containsValue(true)) return Container();

              return Positioned(
                bottom: AppLayout.initNavigationBarHeight + 10,
                child: SizedBox(
                  width: AppLayout.getSize(context).width,
                  child: Center(
                    child: FittedBox(
                      child: Stack(
                        alignment: const Alignment(1.2, -1.5),
                        children: [
                          FloatingActionButton.extended(
                            onPressed: () => Get.to(() => const SummaryLessons()),
                            label: Row(
                              children: const [
                                Icon(Ionicons.cart_outline),
                                Gap(8),
                                Text("Cart"),
                              ],
                            ),
                          ),

                          //BADGE
                          Container(
                            padding: const EdgeInsets.all(4),
                            constraints: const BoxConstraints(minHeight: 24, minWidth: 24),
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
                              child: Text("${lessonController.selectedLessons.values.where((b) => b == true).length}", style: const TextStyle(color: Colors.white)),
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

  /// TabBar on top of the page to choose between Date/Teacher/Subject
  Container _catalogTabBar() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => currentCatalog = CatalogType.date,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: isCurrentCatalog(CatalogType.date)
                    ? Styles.orangeColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Styles.orangeColor),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6, right: 8),
                    child: Icon(
                      Ionicons.calendar_outline,
                      color: isCurrentCatalog(CatalogType.date)
                          ? Colors.white
                          : Styles.orangeColor,
                    ),
                  ),
                  Text(
                    "Date",
                    style: Styles.textStyle.copyWith(
                        color: isCurrentCatalog(CatalogType.date)
                            ? Colors.white
                            : Styles.orangeColor),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => currentCatalog = CatalogType.teacher,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: isCurrentCatalog(CatalogType.teacher)
                    ? Styles.orangeColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Styles.orangeColor),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6, right: 8),
                    child: Icon(
                      Ionicons.glasses_outline,
                      color: isCurrentCatalog(CatalogType.teacher)
                          ? Colors.white
                          : Styles.orangeColor,
                    ),
                  ),
                  Text(
                    "Teacher",
                    style: Styles.textStyle.copyWith(
                        color: isCurrentCatalog(CatalogType.teacher)
                            ? Colors.white
                            : Styles.orangeColor),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => currentCatalog = CatalogType.subject,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: isCurrentCatalog(CatalogType.subject)
                    ? Styles.orangeColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Styles.orangeColor),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6, right: 8),
                    child: Icon(
                      Ionicons.book_outline,
                      color: isCurrentCatalog(CatalogType.subject)
                          ? Colors.white
                          : Styles.orangeColor,
                    ),
                  ),
                  Text(
                    "Subject",
                    style: Styles.textStyle.copyWith(
                        color: isCurrentCatalog(CatalogType.subject)
                            ? Colors.white
                            : Styles.orangeColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Lists of item based on the current catalog section selected
  Widget _catalogList() {
    if (isCurrentCatalog(CatalogType.date)) {
      if(lessonController.lessons.isEmpty) {
        return const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: EmptyData(text: "There are no lesson today"),
          ),
        );
      }

      // Filter only lesson on the selected date
      Iterable<Lesson> lessons = <Lesson>[];
      lessons = lessonController.lessons.where(
              (l) => l.dateTime.year == _selectedDate.year &&
              l.dateTime.month == _selectedDate.month &&
              l.dateTime.day == _selectedDate.day
      );

      return SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return CardSearch(lessons.elementAt(index), lessonController);
          },
          childCount: lessons.length,
        ),
      );
    } else if (isCurrentCatalog(CatalogType.teacher)) {
      return _generateList(teacherController.teachers);
    } else {
      return _generateList(courseController.courses);
    }
  }

  SliverList _generateList(var list){
    return SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return Center(
              child: Text(list[index].name),
            );
          },
          childCount: list.length,
        )
    );
  }

  Widget _datePicker() {

    DateTime initDate = DateTime(2023, 01, 09);

    return DatePicker(
      initDate,
      height: 100,
      width: 70,
      daysCount: 9,
      inactiveDates: [
        initDate.add(Duration(days: DateTime.saturday - initDate.weekday)),
        initDate.add(Duration(days: DateTime.sunday - initDate.weekday))
      ],
      initialSelectedDate: _selectedDate,
      selectionColor: Styles.blueColor,
      dayTextStyle: Styles.headLineStyle2
          .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
      dateTextStyle: Styles.headLineStyle.copyWith(color: Colors.black),
      monthTextStyle: Styles.headLineStyle4
          .copyWith(color: Colors.black, fontWeight: FontWeight.normal),
      deactivatedColor: Styles.greyColor,
      onDateChange: (selectedDate) {
        // String formattedTime = DateFormat.yMd().format(selectedDate);
        // if(selectLessonController.map[formattedTime] == null) {
        //   selectLessonController.map[formattedTime] = {};
        // }
        setState(() {
          _selectedDate = selectedDate;
        });
        // lessonController.getLessons(_selectedDate);
      },
    );
  }
}
