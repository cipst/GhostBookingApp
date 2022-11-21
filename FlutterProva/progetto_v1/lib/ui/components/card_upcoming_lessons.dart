import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progetto_v1/model/course.dart';
import 'package:progetto_v1/model/teacher.dart';
import 'package:progetto_v1/ui/components/custom_dialog.dart';
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
  bool _notification = false;
  final double _cardWidth = 0.9;

  @override
  Widget build(BuildContext context) {
    // size of the context
    final size = AppLayout.getSize(context);

    return GestureDetector(
      onTap: _onTap,
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
                _lessonInfos(),
              ]
          ),
        ),
      ),
    );
  }

  Padding _lessonInfos() {
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
        child: GestureDetector(
          onTap: () {
            Get.defaultDialog(
              title: "Reminder",
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // StatefulBuilder(
                  //     builder: (context, setState) {
                  SizedBox(
                    width: 50,
                    height: 100,
                    child: CarouselSlider.builder(
                      itemCount: 60,
                      itemBuilder: (context, index, realIndex) {
                        return Text((index+1).toString(), textAlign: TextAlign.center,);
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

                  // return DropdownButton(
                  //   items: [5,10,15,20,30].map((int v) {
                  //     return DropdownMenuItem(
                  //       value: v,
                  //       child: Text(v.toString()),
                  //     );
                  //   }).toList(),
                  //   onChanged: (value) {
                  //     debugPrint(value.toString());
                  //     setState(() {
                  //       _minutesEarly = value!;
                  //     });
                  //   },
                  //   value: _minutesEarly,
                  //   icon: const Icon(Ionicons.chevron_down),
                  //   iconSize: 18,
                  // );
                  //     }
                  // ),
                  const Gap(6),
                  const Text("minutes early"),
                ],
              ),
              actions: [
                _buttonSetReminder(),
              ],

            );
          },
          child: _notificationButton(),
        )
    );
  }

  ElevatedButton _buttonSetReminder() {
    return ElevatedButton(
      onPressed: () {
        DateTime date = widget.dateTime.subtract(Duration(minutes: _minutesEarly));

        // check if the reminder can be set _minutesEarly minutes early
        if(DateTime.now().isAfter(date)){
          // show error
          // Get.defaultDialog(
          //     title: "Operation failed",
          //     titleStyle: Styles.headLineStyle.copyWith(color: Styles.errorColor),
          //     middleText: "Oops...\nLooks like you are trying to travel to the past",
          //     middleTextStyle: Styles.textStyle,
          //     backgroundColor: Colors.white,
          //     actions: [
          //       ElevatedButton(
          //         onPressed: () => Get.back(),
          //         style: ,
          //         child: const Text("Close"),
          //       )
          //     ]
          // );
          Get.dialog(
              CustomDialog(
                ButtonStyle(
                  elevation: const MaterialStatePropertyAll(5),
                  side: MaterialStatePropertyAll(BorderSide(color: Styles.errorColor, width: 2)),
                  backgroundColor: const MaterialStatePropertyAll(Colors.white),
                  foregroundColor: MaterialStatePropertyAll(Styles.errorColor),
                ),
                icon: Icon(Ionicons.alert, color: Styles.errorColor,),
                title: "Operation failed",
                description: "Oops...\nLooks like you are trying to travel to the past",
                btnText: Text("Close", style: Styles.textStyle.copyWith(color: Styles.errorColor)),
                svg: SvgPicture.asset(
                  "assets/illustrations/pink/time_machine.svg",
                  width: 200,
                  height: 200,
                ),
              )
          );
          return;
        }

        setState(() {
          _notification = !_notification;
        });

        NotificationService()
            .scheduledNotification(
            dateTime: widget.dateTime.subtract(Duration(minutes: _minutesEarly)),
            description: "${widget.teacher.name} | ${widget.course.name} | ${DateFormat.Hm().format(widget.dateTime)}"
        );
      },
      child: const Text("Set"),
    );
  }

  Widget _notificationButton() => Material(
    elevation: 3,
    color: Styles.orangeColor,
    borderRadius: BorderRadius.circular(10),
    child:  _notification ?
    const Icon(Ionicons.notifications, color: Colors.white,)
        :
    const Icon(Ionicons.notifications_outline, color: Colors.white,),
  );

  void Function() _onTap(){
    return () => debugPrint("Clicked: ${widget.teacher.name}");
  }
}