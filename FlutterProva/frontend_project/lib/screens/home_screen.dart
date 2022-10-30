import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frontend_project/screens/teacher_screen.dart';
import 'package:frontend_project/utils/app_layout.dart';
import 'package:frontend_project/utils/app_style.dart';
import 'package:frontend_project/utils/card_upcoming_lessons.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppLayout.getSize(context).width,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          //HEADER
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome!",
                    style: Styles.headLineStyle4,
                  ),
                  Text(
                    "Stefano",
                    style: Styles.headLineStyle,
                  ),
                ],
              ),
              Expanded(child: Container()),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    scale: 11,
                    image: AssetImage("book.png"),
                  ),
                ),
              )
            ],
          ),

          //SEARCH BAR
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                focusColor: Styles.orangeColor,
                prefixIcon: const Icon(
                  Ionicons.search,
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Styles.blueColor),
                ),
              ),
            ),
          ),

          //UPCOMING LESSON
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Upcoming Lessons",
                    style: Styles.headLineStyle,
                  ),
                  GestureDetector(
                    onTap: () => debugPrint("See All..."),
                    child: Text(
                      "See All",
                      style:
                          Styles.textStyle.copyWith(color: Styles.orangeColor),
                    ),
                  )
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CardUpcomingLesson(
                      subject: "Italiano",
                      teacher: "Paolo Rossi",
                      image:
                          "https://minimaltoolkit.com/images/randomdata/male/47.jpg",
                      time: "15:00",
                      day: "30 Oct",
                      onTap: () =>
                          Get.to(const TeacherPage(teacher: "Paolo Rossi")),
                    ),
                    CardUpcomingLesson(
                      subject: "Matematica",
                      teacher: "Luca Verdi",
                      image:
                          "https://minimaltoolkit.com/images/randomdata/male/54.jpg",
                      time: "16:00",
                      day: "30 Oct",
                      onTap: () =>
                          Get.to(const TeacherPage(teacher: "Luca Verdi")),
                    ),
                    CardUpcomingLesson(
                      subject: "Storia",
                      teacher: "Francesca Neri",
                      image:
                          "https://minimaltoolkit.com/images/randomdata/female/27.jpg",
                      time: "17:00",
                      day: "30 Oct",
                      hasMargRight: false,
                      onTap: () =>
                          Get.to(const TeacherPage(teacher: "Francesca Neri")),
                    ),
                  ],
                ),
              )
            ],
          ),

          //CATALOG
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Catalog",
                    style: Styles.headLineStyle,
                  ),
                  GestureDetector(
                    onTap: () => debugPrint("History..."),
                    child: Text(
                      "History",
                      style:
                          Styles.textStyle.copyWith(color: Styles.orangeColor),
                    ),
                  )
                ],
              ),
              CarouselSlider(
                items: [
                  Container(
                    width: AppLayout.getSize(context).width,
                    color: Colors.red,
                    child: const Center(
                      child: Text("1"),
                    ),
                  ),
                  Container(
                    width: AppLayout.getSize(context).width,
                    color: Colors.red,
                    child: const Center(
                      child: Text("2"),
                    ),
                  ),
                  Container(
                    width: AppLayout.getSize(context).width,
                    color: Colors.red,
                    child: const Center(
                      child: Text("3"),
                    ),
                  ),
                ],
                options: CarouselOptions(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
