import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progetto_v1/model/course.dart';
import 'package:progetto_v1/model/teacher.dart';
import 'package:progetto_v1/ui/components/reminder_dialog.dart';
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
  bool _notification = false;
  final double _cardWidth = 0.9;
  final TextEditingController _textController = TextEditingController();

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
                Positioned(
                    top: 10,
                    right: 10,
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                      onTap: () {
                        Get.defaultDialog(
                          title: "Reminder",
                          content: ReminderDialog(controller: _textController),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                // TODO --> TO FIX: NOT WORKING
                                debugPrint("clicked");
                                int m = int.parse(_textController.text);
                                debugPrint("minutes: $m");
                                if(m>0) {
                                  Get.back(); //close dialog
                                  setState(() {
                                    _notification = !_notification;
                                  });
                                  NotificationService()
                                      .scheduledNotification(
                                      dateTime: widget.dateTime.subtract(Duration(minutes: m)),
                                      description: "${widget.teacher.name} | "
                                          "${widget.course.name} | "
                                          "${DateFormat.Hm().format(widget.dateTime)}"
                                  );
                                }
                              },
                              child: const Text("Set"),
                            ),
                          ],

                        );
                      },
                      child: _notificationButton(),
                    )
                ),
                Padding(
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
                ),
              ]
          ),
        ),
      ),
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
    return () => null;
  }
}
