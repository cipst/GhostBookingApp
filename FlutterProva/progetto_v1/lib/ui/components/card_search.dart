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
import 'package:progetto_v1/utils/app_style.dart';

class CardSearch extends StatefulWidget {
  final Lesson lesson;
  final LessonController lessonController;

  const CardSearch(
      this.lesson,
      this.lessonController,
      {super.key});

  @override
  State<CardSearch> createState() => _CardSearchState();
}

class _CardSearchState extends State<CardSearch> {
  final bookingController = Get.put(BookingController());
  final lessonController = Get.put(LessonController());
  final navigationController = Get.put(NavigationController());


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(),
      onLongPress: () {
        widget.lessonController.selectedLessons[widget.lesson] = !(widget.lessonController.selectedLessons[widget.lesson] ?? false);
      },
      child:Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 25),
        child: Stack(children: [
          _gestureBox(),
          _lessonInfo(),
        ]),
      ),
    );
  }

  Padding _lessonInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              width: 80,
              height: 80,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage("assets/images/${widget.lesson.teacher.toLowerCase().replaceAll(" ", "_")}.jpg"),
                ),
              )
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.lesson.teacher,
                style: Styles.headLineStyle2.copyWith(color: Colors.black),
              ),
              const Gap(6),
              Text(
                widget.lesson.course,
                style: Styles.textStyle,
              ),
              const Gap(8),
              Row(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        size: 15,
                      ),
                      const Gap(4),
                      Text(
                          DateFormat.MMMd().format(widget.lesson.dateTime))
                    ],
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_outlined,
                        size: 15,
                      ),
                      const Gap(4),
                      Text(DateFormat.Hm().format(widget.lesson.dateTime))
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Positioned _gestureBox() {
    return Positioned(
      top: 0,
      right: 0,
      width: 100,
      height: 120,
      child: GestureDetector(
        onTap: () {
          widget.lessonController.selectedLessons[widget.lesson] = !(widget.lessonController.selectedLessons[widget.lesson] ?? false);
        },
        onLongPress: () {
          widget.lessonController.selectedLessons[widget.lesson] = !(widget.lessonController.selectedLessons[widget.lesson] ?? false);
        },
        child: Obx(() =>
            Checkbox(
              fillColor: MaterialStatePropertyAll(Styles.blueColor),
              onChanged: (bool? value) {
                widget.lessonController.selectedLessons[widget.lesson] = value ?? false;
              },
              value: widget.lessonController.selectedLessons.entries.where((e) => e.key.id == widget.lesson.id && e.value == true).isNotEmpty,
            ),
        ),
      ),
    );
  }

  void _onTap() => Get.dialog(
      DefaultTextStyle(
        style: Styles.textStyle,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 36),
          padding: const EdgeInsets.symmetric(horizontal: 60),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(20),
              CircleAvatar(
                radius: 100,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage("assets/images/${widget.lesson.teacher.toLowerCase().replaceAll(" ", "_")}.jpg"),
                    ),
                  ),
                ),
              ),
              const Gap(15),
              Text(widget.lesson.teacher, style: Styles.titleStyle, textAlign: TextAlign.center,),
              const Gap(30),
              Text(
                "Summary",
                style: Styles.headLineStyle.copyWith(
                  color: Styles.blueColor,
                ),
              ),
              const Gap(20),
              Column(children: [
                // SUBJECT
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(
                      Ionicons.library_outline,
                    ),
                    const Gap(10),
                    Text(
                      widget.lesson.course,
                      style: Styles.headLineStyle2.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const Gap(20),

                // DATE
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(Ionicons.calendar_outline),
                    const Gap(10),
                    Text(
                      DateFormat.MMMMd().format(widget.lesson.dateTime),
                      style: Styles.headLineStyle2.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const Gap(20),

                // TIME
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(Ionicons.time_outline),
                    const Gap(10),
                    Text(
                      DateFormat.Hm().format(widget.lesson.dateTime),
                      style: Styles.headLineStyle2.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ]),
              const Gap(60),

              // RESERVATION
              ElevatedButton(
                onPressed: () async {
                  try {
                    Booking b = Booking(
                        lesson: widget.lesson.id!,
                        user: UserController.user.value!.email,
                        status: StatusType.active);
                    await bookingController.setBooking(b); // add booked lesson into the db
                    // bookingController.bookings.add(b);
                    lessonController.selectedLessons.clear(); // remove all eventually selected lessons

                    Get.back();
                    Get.dialog(
                      CustomDialog(
                        title: "Lesson added to the catalog",
                        titleColor: Styles.successColor,
                        description: "The selected lesson have been successfully added to the catalog",
                        icon: Icon(Ionicons.checkmark, color: Styles.successColor, size: 50,),
                        btnText: Text("Close", style: Styles.textStyle.copyWith(color: Colors.white)),
                        btnStyle: Styles.successButtonStyle,
                      ),
                    );

                    navigationController.currentIndex = Pages.home;
                  }on Exception catch(e){
                    debugPrint(e.toString());
                    Get.dialog(
                      CustomDialog(
                        title: "Lesson NOT added to the catalog",
                        titleColor: Styles.errorColor,
                        description: "The selected lesson have NOT been added to the catalog.\nOperation failed!",
                        icon: Icon(Ionicons.close, color: Styles.errorColor, size: 50),
                        btnText: Text("Close", style: Styles.textStyle.copyWith(color: Colors.white)),
                        btnStyle: Styles.errorButtonStyle,
                      ),
                    );
                  }on Error catch(e){
                    debugPrint(e.toString());
                    Get.dialog(
                      CustomDialog(
                        title: "Lesson NOT added to the catalog",
                        titleColor: Styles.errorColor,
                        description: "The selected lesson have NOT been added to the catalog.\nOperation failed!",
                        icon: Icon(Ionicons.close, color: Styles.errorColor, size: 50),
                        btnText: Text("Close", style: Styles.textStyle.copyWith(color: Colors.white)),
                        btnStyle: Styles.errorButtonStyle,
                      ),
                    );
                  }
                },
                style: Styles.successButtonStyle,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Gap(6),
                    Text(
                      "Book",
                      style:
                      Styles.headLineStyle3.copyWith(color: Colors.white),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 1),
                      child: Icon(
                        Ionicons.checkmark,
                      ),
                    )
                  ],
                ),
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
      transitionCurve: Curves.easeInOut
  );
}
