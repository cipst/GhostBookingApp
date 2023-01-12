import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progetto_v1/controller/booking_controller.dart';
import 'package:progetto_v1/controller/lesson_controller.dart';
import 'package:progetto_v1/controller/navigation_controller.dart';
import 'package:progetto_v1/controller/user_controller.dart';
import 'package:progetto_v1/model/booking.dart';
import 'package:progetto_v1/model/lesson.dart';
import 'package:progetto_v1/ui/components/custom_dialog.dart';
import 'package:progetto_v1/utils/app_layout.dart';
import 'package:progetto_v1/utils/app_style.dart';

class SummaryLessons extends StatefulWidget {
  const SummaryLessons({Key? key}) : super(key: key);

  @override
  State<SummaryLessons> createState() => _SummaryLessonsState();
}

class _SummaryLessonsState extends State<SummaryLessons> {
  final LessonController lessonController = Get.put(LessonController());
  final BookingController bookingController = Get.put(BookingController());
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
                                              child: Text(lesson.teacher),
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
                                              child: Text(lesson.course),
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

                                // Delete SelectedLesson button
                                Expanded(
                                  child: GestureDetector(
                                      onTap: (){
                                        lessonController.selectedLessons.removeWhere((key, value) => key == lesson);

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
                          side: MaterialStatePropertyAll(BorderSide(color: Styles.errorColor, width: 2)),
                          backgroundColor: MaterialStatePropertyAll(Styles.bgColor),
                          foregroundColor: MaterialStatePropertyAll(Styles.errorColor),
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
                          try{
                            lessonController.selectedLessons.forEach((key, value) async {
                              Booking b = Booking(
                                  lesson: key.id!,
                                  user: UserController.user.value!.email,
                                  status: StatusType.active);
                              await bookingController.setBooking(b); // add booked lesson into the db
                              // bookingController.bookings.add(b); // add booked lesson into the list of booked lessons
                            });

                            Get.back();
                            Get.dialog(
                              CustomDialog(
                                title: "${lessonController.selectedLessons.length > 1 ? "Lessons" : "Lesson"} added to the catalog",
                                titleColor: Styles.successColor,
                                description: "The selected ${lessonController.selectedLessons.length > 1 ? "lessons" : "lesson"} have been successfully added to the catalog",
                                icon: Icon(Ionicons.checkmark, color: Styles.successColor, size: 50,),
                                btnText: Text("Close", style: Styles.textStyle.copyWith(color: Colors.white)),
                                btnStyle: Styles.successButtonStyle,
                              ),
                            );

                            lessonController.selectedLessons.forEach((key, value) {
                              lessonController.lessons.removeWhere((l) => key == l);
                            });

                            navigationController.currentIndex = Pages.home;
                            lessonController.selectedLessons.clear();

                          } on Exception catch(e){
                            debugPrint(e.toString());
                            Get.dialog(
                              CustomDialog(
                                title: "${lessonController.selectedLessons.length > 1 ? "Lessons" : "Lesson"} NOT added to the catalog",
                                titleColor: Styles.errorColor,
                                description: "The selected ${lessonController.selectedLessons.length > 1 ? "lessons" : "lesson"} have NOT been added to the catalog.\nOperation failed!",
                                icon: Icon(Ionicons.close, color: Styles.errorColor, size: 50),
                                btnText: Text("Close", style: Styles.textStyle.copyWith(color: Colors.white)),
                                btnStyle: Styles.errorButtonStyle,
                              ),
                            );
                          } on Error catch(e){
                            debugPrint(e.toString());
                            Get.dialog(
                              CustomDialog(
                                title: "${lessonController.selectedLessons.length > 1 ? "Lessons" : "Lesson"} NOT added to the catalog",
                                titleColor: Styles.errorColor,
                                description: "The selected ${lessonController.selectedLessons.length > 1 ? "lessons" : "lesson"} have NOT been added to the catalog.\nOperation failed!",
                                icon: Icon(Ionicons.close, color: Styles.errorColor, size: 50),
                                btnText: Text("Close", style: Styles.textStyle.copyWith(color: Colors.white)),
                                btnStyle: Styles.errorButtonStyle,
                              ),
                            );
                          }
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
