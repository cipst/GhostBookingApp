import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progetto_v1/model/booking.dart';
import 'package:progetto_v1/utils/app_style.dart';

class CardSearch extends StatefulWidget {
  final Booking appointment;

  const CardSearch(this.appointment, {super.key});

  @override
  State<CardSearch> createState() => _CardSearchState();
}

class _CardSearchState extends State<CardSearch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(),
      child: Container(
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
                image: NetworkImage(widget.appointment.lesson!.teacher!.image!),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.appointment.lesson!.teacher!.name!,
                style: Styles.headLineStyle2.copyWith(color: Colors.black),
              ),
              const Gap(6),
              Text(
                widget.appointment.lesson!.course!.name!,
                style: Styles.textStyle,
              ),
              const Gap(8),
              Row(
                children: [
                  const Icon(
                    Icons.access_time_outlined,
                    size: 15,
                  ),
                  const Gap(4),
                  Text(DateFormat.Hm().format(widget.appointment.lesson.dateTime!))
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
      child: Container(
          decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        color: Styles.blueColor,
      )),
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
                          image: NetworkImage(
                              widget.appointment.lesson!.teacher!.image!))),
                ),
              ),
              const Gap(15),
              Text(widget.appointment.lesson!.teacher!.name!,
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
                      widget.appointment.lesson!.course!.name!,
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
                      DateFormat.MMMMd().format(widget.appointment.lesson.dateTime!),
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
                      DateFormat.Hm().format(widget.appointment.lesson.dateTime!),
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
                onPressed: () {
                  Get.snackbar(
                      "RESERVATION", widget.appointment.lesson!.teacher!.name!);
                  _dialogConfirmedReservation;
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
      transitionCurve: Curves.easeInOut);

  Future<dynamic> _dialogConfirmedReservation() {
    return Get.defaultDialog(
        title: "Confirmed reservation",
        titleStyle: Styles.headLineStyle,
        middleText: "You have successfully reserved a repetition!",
        middleTextStyle: Styles.textStyle,
        actions: [
          ElevatedButton(
            onPressed: () => Get.back(),
            style: Styles.blueButtonStyleOutline,
            child: const Text("Close"),
          ),
        ]);
  }
}
