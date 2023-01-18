import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:progetto_v1/controller/booking_controller.dart';
import 'package:progetto_v1/controller/course_controller.dart';
import 'package:progetto_v1/controller/lesson_controller.dart';
import 'package:progetto_v1/controller/navigation_controller.dart';
import 'package:progetto_v1/controller/teacher_controller.dart';
import 'package:progetto_v1/model/booking.dart';
import 'package:progetto_v1/model/teacher.dart';
import 'package:progetto_v1/ui/components/card_lesson.dart';
import 'package:progetto_v1/ui/components/empty_data.dart';
import 'package:progetto_v1/utils/app_layout.dart';
import 'package:progetto_v1/utils/app_style.dart';
import 'package:ionicons/ionicons.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {

  final bookingController = Get.put(BookingController());
  final lessonController = Get.put(LessonController());
  final teacherController = Get.put(TeacherController());
  final courseController = Get.put(CourseController());
  final navigationController = Get.put(NavigationController());
  final scrollController = ScrollController();

  final _dates = [
    null,
    DateTime(2023, 01, 09),
    DateTime(2023, 01, 10),
    DateTime(2023, 01, 11),
    DateTime(2023, 01, 12),
    DateTime(2023, 01, 13),
    DateTime(2023, 01, 16),
    DateTime(2023, 01, 17)
  ];
  final _hours = [null, 15, 16, 17, 18, 19];
  final List<String?> _teachers = [null];
  final List<String?> _courses = [null];

  final Map<String, dynamic> filters = {};

  @override
  void initState() {
    bookingController.getAllBookings("stefano.cipolletta@gmail.com");
    teacherController.getAllTeachers();
    courseController.getAllCourses();

    super.initState();
  }

  BoxDecoration _dropDownDecoration() => BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Styles.orangeColor, width:2),
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.57),
            blurRadius: 5
        )
      ]
  );

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      teacherController.teachers.map((t) => _teachers.add(t.name));
      courseController.courses.map((c) => _courses.add(c.name));
    });

    return
      CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                backgroundColor: MaterialStatePropertyAll(
                                    (filters.containsValue(StatusType.active))
                                        ? Styles.successColor
                                        : Colors.white
                                ),
                                side: MaterialStatePropertyAll(BorderSide(color: Styles.successColor))
                            ),
                            onPressed: () => _setFilter("status", StatusType.active),
                            child: Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: (filters.containsValue(StatusType.active))
                                          ? Colors.white
                                          : Styles.successColor,
                                    ),
                                  ),
                                  const Gap(8),
                                  Text("Active", style: Styles.headLineStyle4.copyWith(
                                      color: (filters.containsValue(StatusType.active))
                                          ? Colors.white
                                          : Styles.successColor
                                  ),),
                                ]
                            ),
                          )
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                backgroundColor: MaterialStatePropertyAll(
                                    (filters.containsValue(StatusType.complete))
                                        ? Styles.errorColor
                                        : Colors.white
                                ),
                                side: MaterialStatePropertyAll(BorderSide(color: Styles.errorColor))
                            ),
                            onPressed: () => _setFilter("status", StatusType.complete),
                            child: Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: (filters.containsValue(StatusType.complete))
                                          ? Colors.white
                                          : Styles.errorColor,
                                    ),
                                  ),
                                  const Gap(8),
                                  Text("Completed", style: Styles.headLineStyle4.copyWith(
                                      color: (filters.containsValue(StatusType.complete))
                                          ? Colors.white
                                          : Styles.errorColor
                                  ),),
                                ]
                            ),
                          )
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                backgroundColor: MaterialStatePropertyAll(
                                    (filters.containsValue(StatusType.cancel))
                                        ? Styles.greyColor
                                        : Colors.white
                                ),
                                side: MaterialStatePropertyAll(BorderSide(color: Styles.greyColor))
                            ),
                            onPressed: () => _setFilter("status", StatusType.cancel),
                            child: Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: (filters.containsValue(StatusType.cancel))
                                          ? Colors.white
                                          : Styles.greyColor,
                                    ),
                                  ),
                                  const Gap(8),
                                  Text("Cancelled", style: Styles.headLineStyle4.copyWith(
                                      color: (filters.containsValue(StatusType.cancel))
                                          ? Colors.white
                                          : Styles.greyColor
                                  ),),
                                ]
                            ),
                          )
                      ),
                    ]
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        children: [
                          DecoratedBox(
                            decoration: _dropDownDecoration(),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 15, right: 10),
                                child: DropdownButton<DateTime>(
                                  value: filters["date"],
                                  items: _dates.map((DateTime? d) {
                                    return DropdownMenuItem(
                                      value: d,
                                      child: d!=null ? Text(DateFormat.yMd().format(d), style: Styles.headLineStyle4.copyWith(color: Styles.textColor),) : const Text("Dates"),
                                    );
                                  }).toList(),
                                  borderRadius: BorderRadius.circular(10),
                                  onChanged: (DateTime? newDate) => _setFilter("date", newDate),
                                  underline: Container(),
                                  style: Styles.headLineStyle4.copyWith(color: Styles.orangeColor),
                                  icon: Icon(Ionicons.chevron_down, size: 20, color: Styles.orangeColor,),
                                )
                            ),
                          ),
                          const Gap(20),
                          DecoratedBox(
                            decoration: _dropDownDecoration(),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 15, right: 10),
                                child: DropdownButton<int>(
                                  value: filters["time"],
                                  items: _hours.map((int? h) {
                                    return DropdownMenuItem(
                                      value: h,
                                      child: h!=null ? Text("$h:00", style: Styles.headLineStyle4.copyWith(color: Styles.textColor),) : const Text("Hours"),
                                    );
                                  }).toList(),
                                  borderRadius: BorderRadius.circular(10),
                                  onChanged: (int? newTime) => _setFilter("time", newTime),
                                  underline: Container(),
                                  style: Styles.headLineStyle4.copyWith(color: Styles.orangeColor),
                                  icon: Icon(Ionicons.chevron_down, size: 20, color: Styles.orangeColor,),
                                )
                            ),
                          ),
                          const Gap(20),
                          DecoratedBox(
                            decoration: _dropDownDecoration(),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 15, right: 10),
                                child: DropdownButton<String>(
                                  value: filters["teacher"],
                                  items: _teachers.map((String? t) {
                                    return DropdownMenuItem(
                                      value: t,
                                      child: t!=null ? Text(t, style: Styles.headLineStyle4.copyWith(color: Styles.textColor),) : const Text("Teacher"),
                                    );
                                  }).toList(),
                                  borderRadius: BorderRadius.circular(10),
                                  onChanged: (String? newTeacher) => _setFilter("teacher", newTeacher),
                                  underline: Container(),
                                  style: Styles.headLineStyle4.copyWith(color: Styles.orangeColor),
                                  icon: Icon(Ionicons.chevron_down, size: 20, color: Styles.orangeColor,),
                                )
                            ),
                          ),
                          const Gap(20),
                          DecoratedBox(
                            decoration: _dropDownDecoration(),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 15, right: 10),
                                child: DropdownButton<String>(
                                  value: filters["course"],
                                  items: _courses.map((String? c) {
                                    return DropdownMenuItem(
                                      value: c,
                                      child: c!=null ? Text(c, style: Styles.headLineStyle4.copyWith(color: Styles.textColor),) : const Text("Subject"),
                                    );
                                  }).toList(),
                                  borderRadius: BorderRadius.circular(10),
                                  onChanged: (String? newCourse) => _setFilter("course", newCourse),
                                  underline: Container(),
                                  style: Styles.headLineStyle4.copyWith(color: Styles.orangeColor),
                                  icon: Icon(Ionicons.chevron_down, size: 20, color: Styles.orangeColor,),
                                )
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
              ],
            ),
            centerTitle: true,
            floating: true,
            backgroundColor: Colors.white,
            toolbarHeight: 120,
          ),
          Obx(() =>
          bookingController.bookingsFiltered.isEmpty ?
          SliverToBoxAdapter(
            child: Container(
                margin: const EdgeInsets.only(top: 70),
                child: const EmptyData(text: "No lessons in the catalog")
            ),
          )
              :
          SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: bookingController.bookingsFiltered.length,
                    (context, index){
                  return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CardLesson(
                        bookingController.bookingsFiltered.keys.elementAt(index),
                        bookingController.bookingsFiltered.values.elementAt(index),
                        getAll: true,
                      )
                  );
                }),
          )

          ),
          SliverToBoxAdapter(
            child: Gap(AppLayout.initNavigationBarHeight + 10),
          )
        ],
      );
  }

  void _setFilter(String key, dynamic value){
    debugPrint(key);
    debugPrint("$filters");
    if((filters.containsKey(key) && value == null) || filters.containsValue(value) || value == null){
      filters.removeWhere((k, _) => k == key);
    }else{
      filters[key] = value;
    }
    debugPrint("$filters");
    setState((){});
    bookingController.applyFilters("stefano.cipolletta@gmail.com", filters);
  }

// void _getByStatus(StatusType status) {
//
//   if(filterStatus == status){
//     filterStatus = null;
//     bookingController.getAllBookings("stefano.cipolletta@gmail.com");
//   }else{
//     filterStatus = status;
//     bookingController.getBookingByStatus("stefano.cipolletta@gmail.com", status);
//   }
//   setState((){});
// }
}