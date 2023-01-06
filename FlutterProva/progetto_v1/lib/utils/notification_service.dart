// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:progetto_v1/main.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:progetto_v1/ui/components/custom_dialog.dart';
// import 'package:progetto_v1/utils/app_style.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// class NotificationService {
//   static int n = 0;
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   Future<void> init() async {
//     const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('book');
//     const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
//
//     tz.initializeTimeZones();
//     final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZoneName));
//
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
//   }
//
//   void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
//     final String? payload = notificationResponse.payload;
//     if (notificationResponse.payload != null) {
//       debugPrint('notification payload: $payload');
//     }
//     Get.to(() => const Root());
//
//     // Get.defaultDialog(
//     //   title: notificationResponse.id.toString(),
//     // );
//
//     // await Navigator.push(
//     //   context,
//     //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
//     // );
//   }
//
//   void displayNotification({required String title, required String body}) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'channel id',
//       'channel name',
//       channelDescription: 'channel description',
//       importance: Importance.high,
//       priority: Priority.high,
//       icon: "book",
//     );
//
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       n++,
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: 'Payload',
//     );
//   }
//
//   void scheduledNotification({required DateTime dateTime, required String description}) async {
//     final Duration duration = dateTime.difference(DateTime.now());
//
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         n++,
//         "Incoming lesson",
//         description,
//         tz.TZDateTime.now(tz.local).add(duration),
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'channel id',
//             'channel name',
//             channelDescription: 'channel description',
//             importance: Importance.high,
//             priority: Priority.high,
//             icon: "book",
//           ),
//         ),
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime);
//
//     Get.dialog(
//       CustomDialog(
//         title: "Reminder set",
//         titleColor: Styles.successColor,
//         description: "Reminder succesfully set to ${DateFormat.MMMMd().format(dateTime)} at ${DateFormat.Hm().format(dateTime)}",
//         icon: Icon(Ionicons.checkmark, color: Styles.successColor,),
//         btnText: Text("Close", style: Styles.textStyle.copyWith(color: Colors.white)),
//         btnStyle: Styles.successButtonStyle,
//         svgPath:"assets/illustrations/green/clock.svg",
//       ),
//     );
//   }
//
//   int getId(){
//     return n>0 ? n-1 : n;
//   }
//
//   void cancelNotification({required int id}) async {
//     await flutterLocalNotificationsPlugin.cancel(id);
//   }
// }