import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progetto_v1/controller/booking_controller.dart';
import 'package:progetto_v1/controller/lesson_controller.dart';
import 'package:progetto_v1/controller/navigation_controller.dart';
import 'package:progetto_v1/controller/user_controller.dart';
import 'package:progetto_v1/ui/components/card_lesson.dart';
import 'package:progetto_v1/ui/components/empty_data.dart';
import 'package:progetto_v1/utils/app_layout.dart';
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
  final BookingController bookingController = Get.put(BookingController());
  final LessonController lessonController = Get.put(LessonController());

  final _today = DateTime(2023, 01, 09);

  @override
  void initState() {
    bookingController.getBookingByDate("stefano.cipolletta@gmail.com", DateFormat.yMd().format(_today));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        _header(),
        _searchBar(),
        Obx(() => _todayLessons()),
        Gap(AppLayout.initNavigationBarHeight),
      ],
    );
  }

  Padding _todayLessons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Today's Lessons",
                      style: Styles.headLineStyle,
                    ),
                    bookingController.bookings.isEmpty
                        ?
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
                        :
                    GestureDetector(
                      onTap: () =>
                      navigationController.currentIndex = Pages.catalog,
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
                const Gap(4),
                Text(
                  DateFormat("dd/MM/yyyy").format(_today),
                  style: Styles.headLineStyle4,
                )
              ],
            ),
          ),
          bookingController.bookings.isEmpty
              ?
          const EmptyData(text: "You have no lesson today")
              :
          Obx(() => Column(
            mainAxisSize: MainAxisSize.max,
            children: List.generate(bookingController.lessons.length,
                    (index) =>
                    CardLesson(
                      bookingController.bookings[index],
                      bookingController.lessons.elementAt(index),
                      key: bookingController.keys[index],
                    )
            ),
          )
          ),
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
              Obx(() =>
                  Text(
                    UserController.user.value?.name ?? "",
                    style: Styles.headLineStyle,
                  ),
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

}
