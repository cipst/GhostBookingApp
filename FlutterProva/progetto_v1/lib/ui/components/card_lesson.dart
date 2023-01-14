import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progetto_v1/controller/booking_controller.dart';
import 'package:progetto_v1/controller/navigation_controller.dart';
import 'package:progetto_v1/model/booking.dart';
import 'package:progetto_v1/model/lesson.dart';
import 'package:progetto_v1/ui/components/custom_dialog.dart';
import 'package:progetto_v1/utils/app_layout.dart';
import 'package:progetto_v1/utils/app_style.dart';

class CardLesson extends StatefulWidget {
  final Booking appointment;
  final Lesson lesson;
  final bool getAll;

  const CardLesson(this.appointment, this.lesson, {required this.getAll, super.key});

  @override
  State<CardLesson> createState() => _CardLessonState();
}

class _CardLessonState extends State<CardLesson> {
  final double _cardWidth = 0.9;

  final _navigationController = Get.put(NavigationController());
  final _bookingController = Get.put(BookingController());

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
            _statusBox(),
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

  Positioned _statusBox() {
    var color = widget.appointment.status == StatusType.active ? Styles.successColor
        : widget.appointment.status == StatusType.complete ? Styles.errorColor
        : Styles.greyColor;

    var status = widget.appointment.status == StatusType.active ? "Active"
        : widget.appointment.status == StatusType.complete ? "Completed"
        : "Cancelled";

    return Positioned(
        top: 10,
        right: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: color,
            ),
            color: Colors.white,
          ),
          child: Row(
            children: [
              // BADGE
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: color,
                ),
              ),

              const Gap(8),

              // STATUS
              Text(
                status,
                style: Styles.headLineStyle4.copyWith(
                    color: color
                ),
              ),
            ],
          ),
        )
    );
  }

  void _onTap() {
    var color = widget.appointment.status == StatusType.active ? Styles.successColor
        : widget.appointment.status == StatusType.complete ? Styles.errorColor
        : Styles.greyColor;

    var status = widget.appointment.status == StatusType.active ? "Active"
        : widget.appointment.status == StatusType.complete ? "Completed"
        : "Cancelled";

    Get.dialog(
        DefaultTextStyle(
          style: Styles.textStyle,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 36),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
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
                        const Gap(10),
                        Text(widget.lesson.teacher,
                          style: Styles.titleStyle,
                          textAlign: TextAlign.center,),
                        const Gap(20),
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
                        const Gap(20),

                        (widget.appointment.status != StatusType.active) ?
                        const Gap(20) : Container(),

                        // SHOW IN CATALOG
                        _showInCatalog(),

                        // COMPLETE
                        (widget.appointment.status == StatusType.active) ?
                        _completeLesson() : Container(),

                        // CANCEL
                        (widget.appointment.status == StatusType.active) ?
                        _cancelLesson() : Container(),
                      ],
                    ),
                  ),

                  // STATUS LABEL
                  Positioned(
                      top: 30,
                      right: 30,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: color,
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            // BADGE
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: color,
                              ),
                            ),

                            const Gap(8),

                            // STATUS
                            Text(
                              status,
                              style: Styles.headLineStyle4.copyWith(
                                  color: color
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                ]
            ),
          ),
        ),
        transitionCurve: Curves.easeInOut
    );
  }

  void _onLongPress() {
    var height = (widget.appointment.status == StatusType.active)
        ? AppLayout.getSize(context).height * 0.30
        : AppLayout.initNavigationBarHeight * 2;


    Get.bottomSheet(
      SizedBox(
        height: height,
        child: Column(
          children: [
            Container(
                width: 100,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    color: Styles.greyColor,
                    borderRadius: BorderRadius.circular(30))),

            (widget.appointment.status == StatusType.active)
                ? Gap(height/20)
                : Gap(height/5),

            // SHOW IN CATALOG
            _showInCatalog(),

            (widget.appointment.status == StatusType.active)
                ? Gap(height/20)
                : Container(),

            // COMPLETE
            (widget.appointment.status == StatusType.active)
                ? _completeLesson()
                : Container(),

            (widget.appointment.status == StatusType.active)
                ? Gap(height/20)
                : Container(),

            // CANCEL
            (widget.appointment.status == StatusType.active)
                ? _cancelLesson()
                : Container(),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

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
      try{
        if (widget.appointment.id != null) {
          _bookingController.cancelBooking(widget.appointment.id!, widget.getAll);
        }
        Get.back();
        Get.dialog(
          CustomDialog(
            title: "Lesson set as canceled",
            titleColor: Styles.successColor,
            description: "The selected lesson has been successfully set as canceled",
            icon: Icon(Ionicons.trash_outline, color: Styles.successColor, size: 50,),
            btnText: Text("Close", style: Styles.textStyle.copyWith(color: Colors.white)),
            btnStyle: Styles.successButtonStyle,
          ),
        );
      }on Exception {
        Get.dialog(
          CustomDialog(
            title: "Lesson NOT set as canceled",
            titleColor: Styles.errorColor,
            description: "The selected lesson has NOT been set as canceled.\nOperation failed!",
            icon: Icon(Ionicons.close, color: Styles.errorColor, size: 50),
            btnText: Text("Close", style: Styles.textStyle.copyWith(color: Colors.white)),
            btnStyle: Styles.errorButtonStyle,
          ),
        );
      }on Error {
        Get.dialog(
          CustomDialog(
            title: "Lesson NOT set as canceled",
            titleColor: Styles.errorColor,
            description: "The selected lesson has NOT been set as canceled.\nOperation failed!",
            icon: Icon(Ionicons.close, color: Styles.errorColor, size: 50),
            btnText: Text("Close", style: Styles.textStyle.copyWith(color: Colors.white)),
            btnStyle: Styles.errorButtonStyle,
          ),
        );
      }
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
        ),
        const Gap(10),
      ],
    ),
  );

  ElevatedButton _completeLesson() => ElevatedButton(
    onPressed: (){
      try{
        if (widget.appointment.id != null) {
          _bookingController.completeBooking(widget.appointment.id!, widget.getAll);
        }
        Get.back();
        Get.dialog(
          CustomDialog(
            title: "Lesson set as completed",
            titleColor: Styles.successColor,
            description: "The selected lesson has been successfully set as completed",
            icon: Icon(Ionicons.checkmark_circle, color: Styles.successColor, size: 50,),
            btnText: Text("Close", style: Styles.textStyle.copyWith(color: Colors.white)),
            btnStyle: Styles.successButtonStyle,
          ),
        );
      }on Exception {
        Get.dialog(
          CustomDialog(
            title: "Lesson NOT set as completed",
            titleColor: Styles.errorColor,
            description: "The selected lesson has NOT been set as completed.\nOperation failed!",
            icon: Icon(Ionicons.close, color: Styles.errorColor, size: 50),
            btnText: Text("Close", style: Styles.textStyle.copyWith(color: Colors.white)),
            btnStyle: Styles.errorButtonStyle,
          ),
        );
      }on Error {
        Get.dialog(
          CustomDialog(
            title: "Lesson NOT set as completed",
            titleColor: Styles.errorColor,
            description: "The selected lesson has NOT been set as completed.\nOperation failed!",
            icon: Icon(Ionicons.close, color: Styles.errorColor, size: 50),
            btnText: Text("Close", style: Styles.textStyle.copyWith(color: Colors.white)),
            btnStyle: Styles.errorButtonStyle,
          ),
        );
      }
    },
    style: Styles.orangeButtonStyle,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(6),
        Text(
          "Complete lesson",
          style: Styles.headLineStyle3.copyWith(color: Colors.white),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 1),
          child: Icon(
            Ionicons.checkmark,
          ),
        ),
        const Gap(10),
      ],
    ),
  );
}
