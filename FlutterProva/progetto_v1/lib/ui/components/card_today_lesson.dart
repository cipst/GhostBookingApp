import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progetto_v1/controller/navigation_controller.dart';
import 'package:progetto_v1/model/booking.dart';
import 'package:progetto_v1/model/lesson.dart';
import 'package:progetto_v1/ui/components/custom_dialog.dart';
import 'package:progetto_v1/ui/components/reminder_dialog.dart';
import 'package:progetto_v1/utils/app_layout.dart';
import 'package:progetto_v1/utils/app_style.dart';
import 'package:progetto_v1/utils/notification_service.dart';

class CardTodayLesson extends StatefulWidget {
  final Booking appointment;
  final Lesson lesson;

  const CardTodayLesson(this.appointment, this.lesson, {super.key});

  @override
  State<CardTodayLesson> createState() => _CardTodayLessonState();
}

class _CardTodayLessonState extends State<CardTodayLesson> {
  bool _notification = false;
  final double _cardWidth = 0.9;

  final _controller = TextEditingController();
  final _navigationController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    // size of the context
    final size = AppLayout.getSize(context);

    return GestureDetector(
      onTap: () => _onTap(),
      onLongPress: () => _onLongPress(),
      child: SizedBox(
        width: size.width * _cardWidth,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Stack(children: [
            _notificationBox(),
            _lessonInfo(),
          ]),
        ),
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
              color: Styles.orangeColor,
              image: DecorationImage(
                image: AssetImage("assets/images/${widget.lesson.teacher.toLowerCase().replaceAll(" ", "_")}.jpg"),
              ),
            ),
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

  Positioned _notificationBox() {
    return Positioned(
      top: 10,
      right: 10,
      width: 40,
      height: 40,
      child: ElevatedButton(
        style: Styles.orangeButtonStyle.copyWith(
          padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 0)),
        ),
        onPressed: () {
          _notification ? _dialogCancelReminder() : _dialogSetReminder();
        },
        child: _notification
            ? const Icon(
          Ionicons.notifications,
          color: Colors.white,
        )
            : const Icon(
          Ionicons.notifications_outline,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<dynamic> _dialogSetReminder() {
    // return Get.defaultDialog(
    //   title: "Reminder",
    //   titleStyle: Styles.headLineStyle,
    //   content: Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           SizedBox(
    //             width: 100,
    //             height: 80,
    //             child: TextField(
    //               controller: _controller,
    //               textAlign: TextAlign.center,
    //               decoration: InputDecoration(
    //                 hintText: "5",
    //                 enabledBorder: OutlineInputBorder(
    //                   borderSide: BorderSide(color: Styles.blueColor),
    //                   borderRadius: BorderRadius.circular(10),
    //                 ),
    //                 focusedBorder: OutlineInputBorder(
    //                   borderSide: BorderSide(
    //                     color: Styles.blueColor,
    //                     width: 2,
    //                   ),
    //                   borderRadius: BorderRadius.circular(10),
    //                 ),
    //                 errorBorder: OutlineInputBorder(
    //                   borderSide: BorderSide(
    //                     color: Styles.errorColor,
    //                     width: 2,
    //                   ),
    //                   borderRadius: BorderRadius.circular(10),
    //                 ),
    //               ),
    //               onChanged: (value) {
    //                 if (_controller.text.isEmpty) {
    //                   debugPrint("EMPTY");
    //                   setState(() {
    //                     _errorText = _controller.text;
    //                   });
    //                 } else {
    //                   debugPrint("NOT EMPTY");
    //                   setState(() {
    //                     _errorText = _controller.text;
    //                   });
    //                 }
    //               },
    //               onSubmitted: (value) {
    //                 if (_controller.text.isEmpty) {
    //                   debugPrint("EMPTY");
    //                   setState(() {
    //                     _errorText = _controller.text;
    //                   });
    //                 } else {
    //                   debugPrint("NOT EMPTY");
    //                   setState(() {
    //                     _errorText = _controller.text;
    //                   });
    //                 }
    //               },
    //               keyboardType:
    //                   const TextInputType.numberWithOptions(decimal: false),
    //               inputFormatters: [
    //                 FilteringTextInputFormatter.digitsOnly,
    //               ],
    //             ),
    //           ),
    //           // SizedBox(
    //           //   width: 50,
    //           //   height: 100,
    //           //   child: CarouselSlider.builder(
    //           //     itemCount: 60,
    //           //     itemBuilder: (context, index, realIndex) {
    //           //       return Text(
    //           //         (index + 1).toString(),
    //           //         style: Styles.textStyle,
    //           //         textAlign: TextAlign.center,
    //           //       );
    //           //     },
    //           //     options: CarouselOptions(
    //           //       initialPage: 6,
    //           //       viewportFraction: 0.3,
    //           //       scrollDirection: Axis.vertical,
    //           //       enlargeCenterPage: true,
    //           //       onPageChanged: (index, reason) {
    //           //         setState(() {
    //           //           _minutesEarly = (index + 1);
    //           //         });
    //           //       },
    //           //     ),
    //           //   ),
    //           // ),
    //           const Gap(6),
    //           Text(
    //             "minutes early",
    //             style: Styles.textStyle,
    //           ),
    //         ],
    //       ),
    //       Text(
    //         _errorText,
    //         style: Styles.textStyle.copyWith(color: Styles.errorColor),
    //       )
    //     ],
    //   ),
    //   actions: [
    //     _buttonSetReminder(),
    //   ],
    // );
    return Get.dialog(
      ReminderDialog(
        controller: _controller,
        appointment: widget.appointment,
      ),
    );
  }

  Future<dynamic> _dialogCancelReminder() {
    return Get.defaultDialog(
        title: "Cancel reminder?",
        titleStyle: Styles.headLineStyle,
        middleText:
        // "Reminder set at ${DateFormat.Hm().format(widget.appointment.dateTime!.subtract(Duration(minutes: _minutesEarly)))}\n"
        "\nAre you sure you want to remove the reminder?",
        middleTextStyle: Styles.textStyle,
        actions: [
          ElevatedButton(
            onPressed: () => Get.back(),
            style: Styles.blueButtonStyleOutline,
            child: const Text("Close"),
          ),
          ElevatedButton(
            onPressed: () {
              // if (_id > -1) {
              //   NotificationService().cancelNotification(id: _id);
              // }
              setState(() {
                _notification = false;
              });

              Get.back();

              Get.snackbar("Reminder deleted",
                  "You have successfully deleted the reminder",
                  duration: const Duration(seconds: 6),
                  dismissDirection: DismissDirection.horizontal);
            },
            child: const Text("Confirm"),
          ),
        ]);
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
                      )
                  ),
                ),
              ),
              const Gap(15),
              Text(widget.lesson.teacher,
                  style: Styles.titleStyle),
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
              const Gap(40),

              // SHOW IN CATALOG
              _showInCatalog(),
              const Gap(20),

              // CANCEL
              _cancelLesson(),
              const Gap(20),
            ],
          ),
        ),
      ),
      transitionCurve: Curves.easeInOut);

  void _onLongPress() => Get.bottomSheet(
    SizedBox(
      height: AppLayout.getSize(context).height * 0.20,
      child: Column(
        children: [
          Container(
              width: 100,
              height: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: Styles.greyColor,
                  borderRadius: BorderRadius.circular(30))),

          const Gap(10),

          // SHOW IN CATALOG
          _showInCatalog(),

          const Gap(10),

          // CANCEL
          _cancelLesson(),
        ],
      ),
    ),
    backgroundColor: Colors.white,
  );

  ElevatedButton _showInCatalog() => ElevatedButton(
    onPressed: () {
      _navigationController.currentIndex = Pages.catalog;
      Get.back();
    },
    style: Styles.blueButtonStyle,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(6),
        Text(
          "Show in catalog",
          style: Styles.headLineStyle3.copyWith(color: Colors.white),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 1, left: 5),
          child: Icon(Ionicons.receipt_outline),
        )
      ],
    ),
  );

  ElevatedButton _cancelLesson() => ElevatedButton(
    onPressed: () {
      Get.back();
      Get.snackbar(
          "Cancel lesson", widget.lesson.teacher);
    },
    style: Styles.errorButtonStyleOutline,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(6),
        Text(
          "Cancel lesson",
          style: Styles.headLineStyle3.copyWith(color: Styles.errorColor),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 1),
          child: Icon(
            Ionicons.close_outline,
          ),
        )
      ],
    ),
  );
}
