import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progetto_v1/model/course.dart';
import 'package:progetto_v1/model/teacher.dart';
import 'package:progetto_v1/utils/app_style.dart';

class LessonPage extends StatelessWidget {
  final Course course;
  final Teacher teacher;
  final DateTime dateTime;
  const LessonPage({Key? key, required this.course, required this.teacher, required this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(20),
              CircleAvatar(
                radius: 100,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(image: NetworkImage(teacher.image!))
                  ),
                ),
              ),
              const Gap(15),
              Text(teacher.name!, style: Styles.titleStyle),
              const Gap(30),
              Text("Summary", style: Styles.headLineStyle.copyWith(color: Styles.blueColor,),),
              const Gap(20),
              Container(
                margin: const EdgeInsets.only(left: 60),
                child: Column(
                    children:[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(Ionicons.library_outline,),
                          const Gap(4),
                          Text(course.name, style: Styles.headLineStyle2.copyWith(color: Colors.black,),),
                        ],
                      ),
                      const Gap(20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(Ionicons.calendar_outline),
                          const Gap(4),
                          Text(DateFormat.MMMMd().format(dateTime), style: Styles.headLineStyle2.copyWith(color: Colors.black,),),
                        ],
                      ),
                      const Gap(20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(Ionicons.time_outline),
                          const Gap(4),
                          Text(DateFormat.Hm().format(dateTime), style: Styles.headLineStyle2.copyWith(color: Colors.black,),),
                        ],
                      ),
                    ]
                ),
              ),
              const Gap(40),
              ElevatedButton(
                onPressed: () => Get.snackbar("Show in calendar", teacher.name!),
                style: Styles.blueButtonStyleOutline,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Gap(5),
                    Text("Show in calendar"),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Icon(Ionicons.arrow_forward_outline),
                    )
                  ],
                ),
              ),
              const Gap(20),
              ElevatedButton(
                onPressed: () => Get.snackbar("Delete", teacher.name!),
                style: Styles.errorButtonStyle,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Gap(5),
                    Text("Delete"),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Icon(Ionicons.close_outline,),
                    )
                  ],
                ),
              ),
              const Gap(50),
            ],
          ),
        ),
      ),
    );
  }
}
