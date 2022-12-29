import 'dart:ffi';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progetto_v1/controller/course_controller.dart';
import 'package:progetto_v1/controller/lesson_controller.dart';
import 'package:progetto_v1/controller/teacher_controller.dart';
import 'package:progetto_v1/ui/components/card_search.dart';
import 'package:progetto_v1/ui/components/empty_data.dart';
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
    lessonController.getLessons(_selectedDate);
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

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: _catalogTabBar(),
          backgroundColor: Styles.bgColor,
          shadowColor: Colors.transparent,
          snap: true,
          floating: true,
        ),
        if(lessonController.errorText.value != "")
          SliverToBoxAdapter(
              child: Center(
                child: Obx(() => Text(lessonController.errorText.value)),
              )
          ),

        // if(selectLessonController.list.any((element) => element == true))

        SliverToBoxAdapter(
          child: Center(
            child:  Obx(() => Text("QUI ${lessonController.selectedLessons.containsValue(true)}")),
          ),
        ),

        SliverToBoxAdapter(
          child: Obx(() =>Text("QUI ${lessonController.selectedLessons}")),
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
          child: Gap(AppLayout.initNavigationBarHeight + 5),
        )
      ],
    );

    // const Gap(90),
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

      return SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return CardSearch(
                lessonController.lessons[index],
                _selectedDate,
                index,
                lessonController
            );
          },
          childCount: lessonController.lessons.length,
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
        lessonController.getLessons(_selectedDate);
      },
    );
  }
}
