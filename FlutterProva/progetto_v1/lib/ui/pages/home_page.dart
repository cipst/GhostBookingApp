import 'package:flutter/material.dart';
import 'package:progetto_v1/controller/navigation_controller.dart';
import 'package:progetto_v1/model/booking.dart';
import 'package:progetto_v1/model/lesson.dart';
import 'package:progetto_v1/ui/components/card_today_lesson.dart';
import 'package:progetto_v1/ui/components/empty_data.dart';
import 'package:progetto_v1/utils/app_style.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final navigationController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        _header(),
        _searchBar(),
        _todayLessons(),
        const Gap(80),
      ],
    );
  }

  Padding _todayLessons() {
    return Padding(
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
                  "Today's Lessons",
                  style: Styles.headLineStyle,
                ),
                // Lesson.list.isEmpty
                //     ?
                GestureDetector(
                    onTap: () =>
                        navigationController.currentIndex = Pages.search,
                    child: Row(
                      children: [
                        Text(
                          "Add",
                          style: Styles.textStyle
                              .copyWith(color: Styles.orangeColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Icon(
                            Ionicons.add,
                            size: 12,
                            color: Styles.orangeColor,
                          ),
                        ),
                      ],
                    ))
                // : GestureDetector(
                //     onTap: () =>
                //         navigationController.currentIndex = Pages.catalog,
                //     child: Row(
                //       children: [
                //         Text(
                //           "See All",
                //           style: Styles.textStyle
                //               .copyWith(color: Styles.orangeColor),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(bottom: 2),
                //           child: Icon(
                //             Ionicons.chevron_forward,
                //             size: 12,
                //             color: Styles.orangeColor,
                //           ),
                //         ),
                //       ],
                //     ),
                //   )
              ],
            ),
          ),
          // Lesson.list.isEmpty
          // ?
          const EmptyData(text: "You have no lesson today")
          // : Column(
          //     mainAxisSize: MainAxisSize.max,
          //     children: List.generate(
          //         Lesson.list.length,
          //         (index) => CardTodayLesson(
          //               Appointment(
          //                 Lesson.list[index],
          //                 DateTime.now().add(Duration(hours: index)),
          //               ),
          //             )),
          //   ),
        ],
      ),
    );
  }

  Container _searchBar() {
    return Container(
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
    );
  }

  Padding _header() {
    return Padding(
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
              // color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                scale: 1,
                image: AssetImage("assets/book.png"),
              ),
            ),
          )
        ],
      ),
    );
  }

  // final List<Widget> _data = [
  //   CardUpcomingLesson(
  //     course: "Italiano",
  //     teacher: "Paolo Rossi",
  //     image:
  //     "https://minimaltoolkit.com/images/randomdata/male/47.jpg",
  //     // dateTime: DateTime.parse("2022-11-18 20:19:00"),
  //     dateTime: DateTime.now().add(const Duration(minutes: 2)),
  //     onTap: () =>
  //         Get.to(
  //           Scaffold(appBar: AppBar(), body: const Center(child: Text("Paolo Rossi"))),
  //         ),
  //   ),
  //   CardUpcomingLesson(
  //     course: "Matematica",
  //     teacher: "Luca Verdi",
  //     image:
  //     "https://minimaltoolkit.com/images/randomdata/male/54.jpg",
  //     // dateTime: DateTime.parse("2022-11-30 16:00:00"),
  //     dateTime: DateTime.now().add(const Duration(minutes: 3)),
  //     onTap: () =>
  //         Get.to(
  //           Scaffold(appBar: AppBar(), body: const Center(child: Text("Luca Verdi"))),
  //         ),
  //   ),
  //   CardUpcomingLesson(
  //     course: "Storia",
  //     teacher: "Francesca Neri",
  //     image:
  //     "https://minimaltoolkit.com/images/randomdata/female/27.jpg",
  //     // dateTime: DateTime.parse("2022-11-30 17:00:00"),
  //     dateTime: DateTime.now().add(const Duration(minutes: 1)),
  //     onTap: () =>
  //         Get.to(
  //           Scaffold(appBar: AppBar(), body: const Center(child: Text("Francesca Neri"))),
  //         ),
  //   ),
  //   CardUpcomingLesson(
  //     course: "Storia",
  //     teacher: "Francesca Neri",
  //     image:
  //     "https://minimaltoolkit.com/images/randomdata/female/27.jpg",
  //     // dateTime: DateTime.parse("2022-11-30 17:00:00"),
  //     dateTime: DateTime.now().add(const Duration(minutes: 1)),
  //     onTap: () =>
  //         Get.to(
  //           Scaffold(appBar: AppBar(), body: const Center(child: Text("Francesca Neri"))),
  //         ),
  //   ),
  //   CardUpcomingLesson(
  //     course: "Storia",
  //     teacher: "Francesca Neri",
  //     image:
  //     "https://minimaltoolkit.com/images/randomdata/female/27.jpg",
  //     // dateTime: DateTime.parse("2022-11-30 17:00:00"),
  //     dateTime: DateTime.now().add(const Duration(minutes: 2)),
  //     onTap: () =>
  //         Get.to(
  //           Scaffold(appBar: AppBar(), body: const Center(child: Text("Francesca Neri"))),
  //         ),
  //   ),
  // ];

}
