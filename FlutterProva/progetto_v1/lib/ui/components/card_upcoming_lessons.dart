import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progetto_v1/model/course.dart';
import 'package:progetto_v1/model/teacher.dart';
import 'package:progetto_v1/ui/components/custom_dialog.dart';
import 'package:progetto_v1/ui/pages/lesson_page.dart';
import 'package:progetto_v1/utils/app_layout.dart';
import 'package:progetto_v1/utils/app_style.dart';
import 'package:progetto_v1/utils/notification_service.dart';

class CardUpcomingLesson extends StatefulWidget {
  final Course course;
  final Teacher teacher;
  final DateTime dateTime;

  const CardUpcomingLesson({
    super.key,
    required this.course,
    required this.teacher,
    required this.dateTime,
  });

  @override
  State<CardUpcomingLesson> createState() => _CardUpcomingLessonState();
}

class _CardUpcomingLessonState extends State<CardUpcomingLesson> {
  int _minutesEarly = 1;
  int _id = -1;
  bool _notification = false;
  final double _cardWidth = 0.9;

  @override
  Widget build(BuildContext context) {
    // size of the context
    final size = AppLayout.getSize(context);

    return GestureDetector(
      onTap: () => _onTap(),
      child: SizedBox(
        width: size.width * _cardWidth,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Stack(
              children: [
                _notificationBox(),
                _lessonInfo(),
              ]
          ),
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
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(widget.teacher.image!),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.teacher.name!,
                style: Styles.headLineStyle2.copyWith(color: Colors.black),
              ),
              const Gap(6),
              Text(
                widget.course.name,
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
                      Text(DateFormat.MMMd().format(widget.dateTime))
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
                      Text(DateFormat.Hm().format(widget.dateTime))
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
      child: _notificationButton(),
    );
  }

  Future<dynamic> _dialogSetReminder() {
    return Get.defaultDialog(
      title: "Reminder",
      titleStyle: Styles.headLineStyle,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            height: 100,
            child: CarouselSlider.builder(
              itemCount: 60,
              itemBuilder: (context, index, realIndex) {
                return Text((index+1).toString(), style: Styles.textStyle, textAlign: TextAlign.center,);
              },
              options: CarouselOptions(
                initialPage: 6,
                viewportFraction: 0.3,
                scrollDirection: Axis.vertical,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _minutesEarly = (index + 1);
                  });
                },
              ),
            ),
          ),
          const Gap(6),
          Text("minutes early", style: Styles.textStyle,),
        ],
      ),
      actions: [
        _buttonSetReminder(),
      ],
    );
  }

  Future<dynamic> _dialogCancelReminder() {
    return Get.defaultDialog(
        title: "Cancel reminder?",
        titleStyle: Styles.headLineStyle,
        middleText: "Reminder setted at ${DateFormat.Hm().format(widget.dateTime.subtract(Duration(minutes: _minutesEarly)))}\n"
            "\nAre you sure you want to remove the reminder?",
        middleTextStyle: Styles.textStyle,
        actions: [
          ElevatedButton(
            onPressed: () => Get.back(),
            style: Styles.blueButtonStyleOutline,
            child: const Text("Close"),
          ),
          ElevatedButton(
            onPressed: (){
              if(_id > -1) {
                NotificationService().cancelNotification(id: _id);
              }
              setState((){
                _notification = false;
              });

              Get.back();

              Get.snackbar(
                  "Reminder deleted",
                  "You have successfully deleted the reminder",
                  duration: const Duration(seconds: 6),
                  dismissDirection: DismissDirection.horizontal
              );
            },
            child: const Text("Confirm"),
          ),
        ]
    );
  }

  ElevatedButton _buttonSetReminder() {
    return ElevatedButton(
      onPressed: () {
        DateTime date = widget.dateTime.subtract(Duration(minutes: _minutesEarly));

        // check if the reminder can be set _minutesEarly minutes early
        if(DateTime.now().isAfter(date)){
          Get.dialog(
              CustomDialog(
                icon: Icon(Ionicons.alert, color: Styles.errorColor,),
                title: "Operation failed",
                titleColor: Styles.errorColor,
                description: "Oops...\nLooks like you are trying to travel to the past",
                btnText: Text("Close", style: Styles.textStyle.copyWith(color: Styles.errorColor)),
                btnStyle: Styles.errorButtonStyleOutline,
                svgPath: "assets/illustrations/pink/time_machine.svg",
                svgWidth: 500,
                svgHeight: 500,
              )
          );
          return;
        }

        int id = _scheduleNotification();

        setState(() {
          _id = id;
          _notification = !_notification;
        });

        Get.back();
      },
      child: const Text("Set"),
    );
  }

  int _scheduleNotification() {
    NotificationService()
        .scheduledNotification(
        dateTime: widget.dateTime.subtract(Duration(minutes: _minutesEarly)),
        description: "${widget.teacher.name} | ${widget.course.name} | ${DateFormat.Hm().format(widget.dateTime)}"
    );

    return NotificationService().getId();
  }

  Widget _notificationButton() => ElevatedButton(
    style: Styles.orangeButtonStyle.copyWith(padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 0))),
    onPressed:() {
      _notification ?
      _dialogCancelReminder()
          :
      _dialogSetReminder();
    },
    child: _notification ?
    const Icon(Ionicons.notifications, color: Colors.white,)
        :
    const Icon(Ionicons.notifications_outline, color: Colors.white,),
  );

  void _onTap() => Get.to(
    LessonPage(course: widget.course, teacher: widget.teacher, dateTime: widget.dateTime),
    transition: Transition.fadeIn,
    curve: Curves.easeInOut,
  );
}
