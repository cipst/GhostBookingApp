// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:progetto_v1/controller/lesson_controller.dart';
// import 'package:progetto_v1/model/booking.dart';
// import 'package:progetto_v1/model/lesson.dart';
// import 'package:progetto_v1/ui/components/custom_dialog.dart';
// import 'package:progetto_v1/utils/app_style.dart';
// import 'package:progetto_v1/utils/notification_service.dart';
//
// class ReminderDialog extends StatefulWidget {
//   final TextEditingController controller;
//   final Booking appointment;
//
//   const ReminderDialog({
//     super.key,
//     required this.controller,
//     required this.appointment,
//   });
//
//   @override
//   State<ReminderDialog> createState() => _ReminderDialogState();
// }
//
// class _ReminderDialogState extends State<ReminderDialog> {
//   String? _errorText = "";
//   String _helpText = "";
//   // int _minutesEarly = 0;
//   DateTime _reminder = DateTime.now();
//   int _id = -1;
//
//   final LessonController _lessonController = Get.put(LessonController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       elevation: 20,
//       backgroundColor: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Text(
//               "Reminder",
//               style: Styles.headLineStyle,
//             ),
//             const Gap(15),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: 60,
//                   height: 80,
//                   child: TextField(
//                     controller: widget.controller,
//                     textAlign: TextAlign.center,
//                     decoration: InputDecoration(
//                       hintText: "5",
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Styles.blueColor),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Styles.blueColor,
//                           width: 2,
//                         ),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       errorBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Styles.errorColor,
//                           width: 2,
//                         ),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       errorText: _errorText == null ? null : "",
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Styles.errorColor,
//                           width: 2,
//                         ),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     onChanged: validator,
//                     onSubmitted: validator,
//                     keyboardType:
//                         const TextInputType.numberWithOptions(decimal: false),
//                     inputFormatters: [
//                       FilteringTextInputFormatter.digitsOnly,
//                     ],
//                   ),
//                 ),
//                 const Gap(6),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 20),
//                   child: Text(
//                     "minutes early",
//                     style: Styles.textStyle,
//                   ),
//                 ),
//               ],
//             ),
//             Text(
//               _errorText == null ? _helpText : _errorText!,
//               textAlign: TextAlign.center,
//               style: Styles.textStyle.copyWith(
//                 color: _errorText == null
//                     ? Styles.successColor
//                     : Styles.errorColor,
//               ),
//             ),
//             const Gap(15),
//             _buttonSetReminder(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void validator(value) async {
//     if (widget.controller.text.isEmpty) {
//       _errorText = "Field must not be empty";
//     } else if (widget.controller.text.length > 3) {
//       _errorText = "Input too long";
//     } else {
//       int minutes = int.parse(widget.controller.text);
//       Lesson? lesson = await _lessonController.getLesson(widget.appointment.lesson);
//       DateTime estimatedTime = lesson!.dateTime.subtract(Duration(minutes: minutes));
//       if (estimatedTime.isBefore(DateTime.now())) {
//         _errorText =
//             "You are trying to set the reminder at ${DateFormat.Hm().format(estimatedTime)}";
//       } else {
//         _errorText = null;
//         _helpText =
//             "Setting the reminder at ${DateFormat.Hm().format(estimatedTime)}";
//         _reminder = estimatedTime;
//       }
//     }
//
//     setState(() {});
//   }
//
//   ElevatedButton _buttonSetReminder() {
//     return ElevatedButton(
//       onPressed: _errorText == null
//           ? () {
//               int id = _scheduleNotification();
//
//               setState(() {
//                 _id = id;
//                 // _notification = !_notification;
//               });
//
//               Get.back();
//             }
//           : null,
//       child: const Text("Set"),
//     );
//   }
//
//   // int _scheduleNotification() {
//   //   // NotificationService().scheduledNotification(
//   //   //   dateTime: _reminder,
//   //   //   description:
//   //   //       "${widget.appointment.lesson!.teacher!.name} | ${widget.appointment.lesson!.course!.name} | ${DateFormat.Hm().format(widget.appointment.dateTime!)}",
//   //   // );
//   //
//   //   return NotificationService().getId();
//   // }
// }
