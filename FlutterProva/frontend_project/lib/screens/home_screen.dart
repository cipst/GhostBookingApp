import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frontend_project/screens/teacher_screen.dart';
import 'package:frontend_project/utils/app_layout.dart';
import 'package:frontend_project/utils/app_style.dart';
import 'package:frontend_project/utils/card_upcoming_lessons.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _currentCatalog = "date".obs;

  changeCurrentCatalog(String newCatalog) {
    _currentCatalog.value = newCatalog;
  }

  bool isCurrentCatalog(String checkCatalog) {
    return _currentCatalog.value == checkCatalog;
  }

  @override
  Widget build(BuildContext context) {
    // return SizedBox(
    //   width: AppLayout.getSize(context).width,
    // padding: const EdgeInsets.all(24),
    // child:
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        //HEADER
        Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
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
                    image: AssetImage("assets/book.png"),
                  ),
                ),
              )
            ],
          ),
        ),

        //SEARCH BAR
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
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
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Upcoming Lessons",
                      style: Styles.headLineStyle,
                    ),
                    GestureDetector(
                      onTap: () => debugPrint("See All..."),
                      child: Row(
                        children: [
                          Text(
                            "See All",
                            style: Styles.textStyle
                                .copyWith(color: Styles.orangeColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Icon(
                              Ionicons.chevron_forward,
                              size: 12,
                              color: Styles.orangeColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(vertical: 12),
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
        ),

        //CATALOG
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Catalog",
                    style: Styles.headLineStyle,
                  ),
                  GestureDetector(
                    onTap: () => debugPrint("History..."),
                    child: Row(
                      children: [
                        Text(
                          "History",
                          style: Styles.textStyle
                              .copyWith(color: Styles.orangeColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Icon(
                            Ionicons.chevron_forward,
                            size: 12,
                            color: Styles.orangeColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _catalogTabBar(),
                ),
              ),
            ),
            SizedBox(
              width: AppLayout.getSize(context).width,
              child: _catalogList(),
            ),
          ],
        ),

        const Gap(90),
      ],
    );
    // );
  }

  List<Widget> _catalogTabBar() {
    return [
      GestureDetector(
        onTap: () => changeCurrentCatalog("date"),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color: isCurrentCatalog("date") ? Styles.orangeColor : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Styles.orangeColor),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 6, right: 8),
                child: Icon(
                  Ionicons.calendar_outline,
                  color: isCurrentCatalog("date")
                      ? Colors.white
                      : Styles.orangeColor,
                ),
              ),
              Text(
                "Date",
                style: Styles.textStyle.copyWith(
                    color: isCurrentCatalog("date")
                        ? Colors.white
                        : Styles.orangeColor),
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () => changeCurrentCatalog("teacher"),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color:
                isCurrentCatalog("teacher") ? Styles.orangeColor : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Styles.orangeColor),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 6, right: 8),
                child: Icon(
                  Ionicons.glasses_outline,
                  color: isCurrentCatalog("teacher")
                      ? Colors.white
                      : Styles.orangeColor,
                ),
              ),
              Text(
                "Teacher",
                style: Styles.textStyle.copyWith(
                    color: isCurrentCatalog("teacher")
                        ? Colors.white
                        : Styles.orangeColor),
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () => changeCurrentCatalog("subject"),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color:
                isCurrentCatalog("subject") ? Styles.orangeColor : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Styles.orangeColor),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 6, right: 8),
                child: Icon(
                  Ionicons.book_outline,
                  color: isCurrentCatalog("subject")
                      ? Colors.white
                      : Styles.orangeColor,
                ),
              ),
              Text(
                "Subject",
                style: Styles.textStyle.copyWith(
                    color: isCurrentCatalog("subject")
                        ? Colors.white
                        : Styles.orangeColor),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  List<Map<String, dynamic>> catalogList = [
    {
      "day": "1 Nov",
      "time": "15:00",
      "teacher": "Paolo Rossi",
      "subject": "Scienze"
    },
    {
      "day": "1 Nov",
      "time": "16:00",
      "teacher": "Luca Verdi",
      "subject": "Matematica"
    },
    {
      "day": "1 Nov",
      "time": "17:00",
      "teacher": "Francesca Neri",
      "subject": "Letteratura"
    },
    {
      "day": "1 Nov",
      "time": "18:00",
      "teacher": "Francesca Neri",
      "subject": "Fisica"
    },
    {
      "day": "1 Nov",
      "time": "19:00",
      "teacher": "Luca Verdi",
      "subject": "Chimica"
    },
    {
      "day": "1 Nov",
      "time": "19:00",
      "teacher": "Luca Verdi",
      "subject": "Chimica"
    },
    {
      "day": "1 Nov",
      "time": "19:00",
      "teacher": "Luca Verdi",
      "subject": "Chimica"
    },
    {
      "day": "1 Nov",
      "time": "19:00",
      "teacher": "Luca Verdi",
      "subject": "Chimica"
    },
    {
      "day": "1 Nov",
      "time": "19:00",
      "teacher": "Luca Verdi",
      "subject": "Chimica"
    },
    {
      "day": "1 Nov",
      "time": "19:00",
      "teacher": "Luca Verdi",
      "subject": "Chimica"
    },
    {
      "day": "1 Nov",
      "time": "19:00",
      "teacher": "Luca Verdi",
      "subject": "Chimica"
    },
    {
      "day": "1 Nov",
      "time": "19:00",
      "teacher": "Luca Verdi",
      "subject": "Chimica"
    },
    {
      "day": "1 Nov",
      "time": "19:00",
      "teacher": "Luca Verdi",
      "subject": "Chimica"
    },
    {
      "day": "1 Nov",
      "time": "19:00",
      "teacher": "Luca Verdi",
      "subject": "Chimica"
    },
    {
      "day": "1 Nov",
      "time": "19:00",
      "teacher": "Luca Verdi",
      "subject": "Chimica"
    },
  ];

  Widget _catalogList() {
    // return const Text("PROVA");
    // return ListView.builder(
    //     itemBuilder: (_, i) => Text(catalogList[i]["teacher"]));

    return Column(
      children: List.generate(
          catalogList.length, (index) => Text(catalogList[index]["teacher"])),
    );
  }
}
