import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progetto_v1/controller/course_controller.dart';
import 'package:progetto_v1/controller/lesson_controller.dart';
import 'package:progetto_v1/controller/teacher_controller.dart';
import 'package:progetto_v1/model/lesson.dart';
import 'package:progetto_v1/ui/components/card_search.dart';
import 'package:progetto_v1/ui/components/empty_data.dart';
import 'package:progetto_v1/utils/app_layout.dart';
import 'package:progetto_v1/utils/app_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchStepper extends StatefulWidget {
  const SearchStepper({Key? key}) : super(key: key);

  @override
  State<SearchStepper> createState() => _SearchStepperState();
}

class _SearchStepperState extends State<SearchStepper> {
  final TeacherController teacherController = Get.put(TeacherController());
  final CourseController courseController = Get.put(CourseController());
  final LessonController lessonController= Get.put(LessonController());
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  int? _currentStep;
  int? _teacherSelectedIndex;
  int? _courseSelectedIndex;
  int? _dateSelectedIndex;
  int? _timeSelectedIndex;

  final _dates = [
    DateTime(2023, 01, 09),
    DateTime(2023, 01, 10),
    DateTime(2023, 01, 11),
    DateTime(2023, 01, 12),
    DateTime(2023, 01, 13),
    DateTime(2023, 01, 16),
    DateTime(2023, 01, 17)
  ];
  final _hours = [15, 16, 17, 18, 19];

  _stepTapped(int step) {
    setState(() => _currentStep = (step == _currentStep) ?  4 : step);
    _setPrefInteger("step", _currentStep ?? 4);
  }

  _stepContinue() {
    if(_currentStep != null && _currentStep! <= 3) {
      if(![_teacherSelectedIndex, _courseSelectedIndex, _dateSelectedIndex, _timeSelectedIndex].contains(-1)) {
        _currentStep = 4;
      }else{
        _currentStep = _currentStep! + 1;
      }
      _setPrefInteger("step", _currentStep ?? 4);
    }else{
      _currentStep = 4;
    }
    setState(() {});
  }

  _stepCancel() {
    switch(_currentStep){
    //teacher
      case 0:
        if(_teacherSelectedIndex == -1) break;
        _teacherSelectedIndex = -1;
        _setPrefInteger("teacherIndex", -1);
        break;

    //subject
      case 1:
        if(_courseSelectedIndex == -1) {
          _currentStep = _currentStep! - 1;
          break;
        }
        _courseSelectedIndex = -1;
        _setPrefInteger("courseIndex", -1);
        break;

    //date
      case 2:
        if(_dateSelectedIndex == -1) {
          _currentStep = _currentStep! - 1;
          break;
        }
        _dateSelectedIndex = -1;
        _setPrefInteger("dateIndex", -1);
        break;

    //time
      case 3:
        if(_timeSelectedIndex == -1) {
          _currentStep = _currentStep! - 1;
          break;
        }
        _timeSelectedIndex = -1;
        _setPrefInteger("timeIndex", -1);
        break;

      default:
        break;
    }

    setState(() {});
    _setPrefInteger("step", _currentStep ?? 4);
  }

  _setPrefInteger(String key, int value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setInt(key, value);
  }

  Future<void> _getPreferences() async {
    final SharedPreferences prefs = await _prefs;
    _teacherSelectedIndex = prefs.getInt("teacherIndex") ?? -1;
    _courseSelectedIndex = prefs.getInt("courseIndex") ?? -1;
    _dateSelectedIndex = prefs.getInt("dateIndex") ?? -1;
    _timeSelectedIndex = prefs.getInt("timeIndex") ?? -1;
    _currentStep = prefs.getInt("step") ?? 0;
    return;
  }

  Future<List<Lesson>> _getLessons() async {
    List<Lesson>? tmp;
    List<List<Lesson>> lists = [];

    if(_teacherSelectedIndex != -1) {
      tmp = await lessonController.getLessonsByTeacher(teacherController.teachers.elementAt(_teacherSelectedIndex!).name);
      tmp != null ? lists.add(tmp) : null;
    }

    if(_courseSelectedIndex != null && _courseSelectedIndex != -1) {
      tmp = await lessonController.getLessonsByCourse(courseController.courses.elementAt(_courseSelectedIndex!).name);
      tmp != null ? lists.add(tmp) : null;
    }

    if(_dateSelectedIndex != null && _dateSelectedIndex != -1) {
      String datetime = DateFormat.yMd().format(_dates[_dateSelectedIndex!]);
      if(_timeSelectedIndex != null && _timeSelectedIndex != -1) {
        datetime += " ${_hours[_timeSelectedIndex!]}";
      }
      tmp = await lessonController.getLessonsByDate(datetime);
      tmp != null ? lists.add(tmp) : null;
    }else{
      if(_timeSelectedIndex != null && _timeSelectedIndex != -1) {
        String datetime = "${_hours[_timeSelectedIndex!]}";
        tmp = await lessonController.getLessonsByDate(datetime);
        tmp != null ? lists.add(tmp) : null;
      }
    }

    return lists.fold<Set>(
        lists.first.toSet(),
            (previousValue, element) => previousValue.intersection(element.toSet())
    ).toList() as List<Lesson>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: _getPreferences(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return const EmptyData(text: "Something went wrong...");
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            _teacherSelectedIndex = -1;
            _courseSelectedIndex = -1;
            _dateSelectedIndex = -1;
            _timeSelectedIndex = -1;
            _currentStep = 4;
          }

          return Obx(() =>
              CustomScrollView(
                slivers: [

                  SliverToBoxAdapter(
                    child: Stepper(
                        physics: const ScrollPhysics(),
                        currentStep: _currentStep ?? 0,
                        onStepTapped: (step) => _stepTapped(step),
                        onStepContinue: _stepContinue,
                        onStepCancel: _stepCancel,
                        controlsBuilder: _currentStep == 4 ? (context, _) => Container() : null,
                        steps: [
                          Step(
                            title: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 6, right: 8),
                                  child: Icon(
                                    _teacherSelectedIndex != -1 ? Ionicons.person : Ionicons.person_outline,
                                    color: _teacherSelectedIndex != -1 ? Styles.blueColor : Colors.black,
                                  ),
                                ),
                                Text("Teacher", style: TextStyle(color: _teacherSelectedIndex != -1 ? Styles.blueColor : Colors.black)),
                              ],
                            ),
                            content: Obx(() =>
                                Column(
                                  children: List.generate(
                                    teacherController.teachers.length,
                                        (index) {
                                      return ListTile(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        title: Row(
                                          children: [
                                            Container(
                                                width: 55,
                                                height: 55,
                                                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: AssetImage("assets/images/${teacherController.teachers.elementAt(index).name.toLowerCase().replaceAll(" ", "_")}.jpg"),
                                                  ),
                                                )
                                            ),
                                            Text(teacherController.teachers.elementAt(index).name),
                                          ],
                                        ),
                                        textColor: (_teacherSelectedIndex == index && _currentStep == 0) ? Colors.white : Styles.textColor,
                                        tileColor: (_teacherSelectedIndex == index && _currentStep == 0) ? Styles.blueColor : Colors.transparent,
                                        onTap: (){
                                          setState(() {
                                            _teacherSelectedIndex = index;
                                          });
                                          _setPrefInteger("teacherIndex", index);
                                        },
                                      );
                                    },
                                  ),
                                ),
                            ),
                            isActive: (_currentStep ?? 0) >= 0,
                            state: _teacherSelectedIndex != -1
                                ? StepState.complete
                                : StepState.indexed,
                          ),
                          Step(
                            title: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2, right: 8),
                                  child: Icon(
                                    _courseSelectedIndex != -1 ? Ionicons.book : Ionicons.book_outline,
                                    color: _courseSelectedIndex != -1 ? Styles.blueColor : Colors.black,
                                  ),
                                ),
                                Text("Subject", style: TextStyle(color: _courseSelectedIndex != -1 ? Styles.blueColor : Colors.black)),
                              ],
                            ),
                            content: Obx(() =>
                                Column(
                                  children: List.generate(
                                    courseController.courses.length,
                                        (index) {
                                      return ListTile(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        title: Text(courseController.courses.elementAt(index).name),
                                        textColor: (_courseSelectedIndex == index && _currentStep == 1) ? Colors.white : Styles.textColor,
                                        tileColor: (_courseSelectedIndex == index && _currentStep == 1) ? Styles.blueColor : Colors.transparent,
                                        onTap: (){
                                          setState(() {
                                            _courseSelectedIndex = index;
                                          });
                                          _setPrefInteger("courseIndex", index);
                                        },
                                      );
                                    },
                                  ),
                                ),
                            ),
                            isActive: (_currentStep ?? 0) >= 0,
                            state: _courseSelectedIndex != -1
                                ? StepState.complete
                                : StepState.indexed,
                          ),
                          Step(
                            title: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 6, right: 8),
                                  child: Icon(
                                    _dateSelectedIndex != -1 ? Ionicons.calendar : Ionicons.calendar_outline,
                                    color: _dateSelectedIndex != -1 ? Styles.blueColor : Colors.black,
                                  ),
                                ),
                                Text("Date", style: TextStyle(color: _dateSelectedIndex != -1 ? Styles.blueColor : Colors.black),),
                              ],
                            ),
                            content: Column(
                              children: List.generate(
                                _dates.length,
                                    (index) {
                                  return ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    title: Center(child: Text(DateFormat("dd/MM/yyyy").format(_dates.elementAt(index)))),
                                    textColor: (_dateSelectedIndex == index && _currentStep == 2) ? Colors.white : Styles.textColor,
                                    tileColor: (_dateSelectedIndex == index && _currentStep == 2) ? Styles.blueColor : Colors.transparent,
                                    onTap: (){
                                      setState(() {
                                        _dateSelectedIndex = index;
                                      });
                                      _setPrefInteger("dateIndex", index);
                                    },
                                  );
                                },
                              ),
                            ),
                            isActive: (_currentStep ?? 0) >= 0,
                            state: _dateSelectedIndex != -1
                                ? StepState.complete
                                : StepState.indexed,
                          ),
                          Step(
                            title: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2, right: 8),
                                  child: Icon(
                                    _timeSelectedIndex != -1 ? Ionicons.time : Ionicons.time_outline,
                                    color: _timeSelectedIndex != -1 ? Styles.blueColor : Colors.black,
                                  ),
                                ),
                                Text("Time", style: TextStyle(color: _timeSelectedIndex != -1 ? Styles.blueColor : Colors.black)),
                              ],
                            ),
                            content: Column(
                              children: List.generate(
                                _hours.length,
                                    (index) {
                                  return ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    title: Center(child: Text("${_hours.elementAt(index)}:00")),
                                    textColor: (_timeSelectedIndex == index && _currentStep == 3) ? Colors.white : Styles.textColor,
                                    tileColor: (_timeSelectedIndex == index && _currentStep == 3) ? Styles.blueColor : Colors.transparent,
                                    onTap: (){
                                      setState(() {
                                        _timeSelectedIndex = index;
                                      });
                                      _setPrefInteger("timeIndex", index);
                                    },
                                  );
                                },
                              ),
                            ),
                            isActive: (_currentStep ?? 0) >= 0,
                            state: _timeSelectedIndex != -1
                                ? StepState.complete
                                : StepState.indexed,
                          ),
                          Step(
                            title: const Text("Results"),
                            content: Container(),
                            isActive: (_currentStep ?? 0) >= 0,
                            state: StepState.indexed,
                          )
                        ]
                    ),
                  ),

                  if([_teacherSelectedIndex, _courseSelectedIndex, _dateSelectedIndex, _timeSelectedIndex].every((element) => element == -1))
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: lessonController.lessons.length,
                            (context, index) => CardSearch(lessonController.lessons[index], lessonController),
                      ),
                    ),

                  if(![_teacherSelectedIndex, _courseSelectedIndex, _dateSelectedIndex, _timeSelectedIndex].every((element) => element == null))
                    FutureBuilder<List<Lesson>>(
                        future: _getLessons(),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return const SliverToBoxAdapter(
                                child: Center(child: CircularProgressIndicator(),)
                            );
                          }

                          if(snapshot.data == null || snapshot.data!.isEmpty){
                            return const SliverToBoxAdapter(
                                child: EmptyData(text: "No lessons found")
                            );
                          }

                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: snapshot.data?.length ?? 0,
                                  (context, index) => CardSearch(snapshot.data![index], lessonController),
                            ),
                          );
                        }
                    ),

                  SliverToBoxAdapter(
                    child: Gap(AppLayout.initNavigationBarHeight + 35),
                  )
                ],
              )
          );
        }
    );
  }
}
