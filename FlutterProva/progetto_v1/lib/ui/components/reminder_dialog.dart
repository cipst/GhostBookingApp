import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progetto_v1/model/appointment.dart';
import 'package:progetto_v1/ui/components/custom_dialog.dart';
import 'package:progetto_v1/utils/app_style.dart';
import 'package:progetto_v1/utils/notification_service.dart';

class ReminderDialog extends StatefulWidget {
  final TextEditingController controller;
  final Appointment appointment;
  final DateTime dateTime;

  const ReminderDialog({
    super.key,
    required this.controller,
    required this.appointment,
    required this.dateTime,
  });

  @override
  State<ReminderDialog> createState() => _ReminderDialogState();
}

class _ReminderDialogState extends State<ReminderDialog> {
  String _errorText = "";
  String _helpText = "";
  int _minutesEarly = 0;
  int _id = -1;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Reminder",
              style: Styles.headLineStyle,
            ),
            const Gap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 80,
                  child: TextField(
                    controller: widget.controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "5",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Styles.blueColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.blueColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.errorColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorText: _errorText.isEmpty ? null : "",
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.errorColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: validator,
                    onSubmitted: validator,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                const Gap(6),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    "minutes early",
                    style: Styles.textStyle,
                  ),
                ),
              ],
            ),
            Text(
              _errorText.isNotEmpty ? _errorText : _helpText,
              textAlign: TextAlign.center,
              style: Styles.textStyle.copyWith(
                color: _errorText.isNotEmpty
                    ? Styles.errorColor
                    : Styles.successColor,
              ),
            ),
            const Gap(15),
            _buttonSetReminder(),
          ],
        ),
      ),
    );
  }

  void validator(value) {
    if (widget.controller.text.isEmpty) {
      setState(() {
        _errorText = "Field must not be empty";
      });
      return;
    }

    int _minutes = int.parse(widget.controller.text);
    DateTime _extimatedTime =
        widget.dateTime.subtract(Duration(minutes: _minutes));
    if (_extimatedTime.isBefore(DateTime.now())) {
      setState(() {
        _errorText =
            "You are trying to set the reminder at ${DateFormat.Hm().format(_extimatedTime)}";
      });
      return;
    }

    setState(() {
      _errorText = "";
      _helpText =
          "Setting the reminder at ${DateFormat.Hm().format(_extimatedTime)}";
      _minutesEarly = _minutes;
    });
  }

  ElevatedButton _buttonSetReminder() {
    return ElevatedButton(
      onPressed: _errorText.isNotEmpty
          ? null
          : () {
              DateTime date =
                  widget.dateTime.subtract(Duration(minutes: _minutesEarly));

              // check if the reminder can be set _minutesEarly minutes early
              if (DateTime.now().isAfter(date)) {
                Get.dialog(CustomDialog(
                  icon: Icon(
                    Ionicons.alert,
                    color: Styles.errorColor,
                  ),
                  title: "Operation failed",
                  titleColor: Styles.errorColor,
                  description:
                      "Oops...\nLooks like you are trying to travel to the past",
                  btnText: Text("Close",
                      style:
                          Styles.textStyle.copyWith(color: Styles.errorColor)),
                  btnStyle: Styles.errorButtonStyleOutline,
                  svgPath: "assets/illustrations/pink/time_machine.svg",
                  svgWidth: 500,
                  svgHeight: 500,
                ));
                return;
              }

              int id = _scheduleNotification();

              setState(() {
                _id = id;
                // _notification = !_notification;
              });

              Get.back();
            },
      child: const Text("Set"),
    );
  }

  int _scheduleNotification() {
    NotificationService().scheduledNotification(
        dateTime: widget.dateTime.subtract(Duration(minutes: _minutesEarly)),
        description:
            "${widget.appointment.lesson.teacher.name} | ${widget.appointment.lesson.course.name} | ${DateFormat.Hm().format(widget.appointment.dateTime)}");

    return NotificationService().getId();
  }
}
