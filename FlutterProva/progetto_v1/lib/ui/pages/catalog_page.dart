import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:progetto_v1/controller/booking_controller.dart';
import 'package:progetto_v1/controller/lesson_controller.dart';
import 'package:progetto_v1/controller/navigation_controller.dart';
import 'package:progetto_v1/controller/user_controller.dart';
import 'package:progetto_v1/model/booking.dart';
import 'package:progetto_v1/model/lesson.dart';
import 'package:progetto_v1/ui/components/card_lesson.dart';
import 'package:progetto_v1/ui/components/empty_data.dart';
import 'package:progetto_v1/utils/app_layout.dart';
import 'package:progetto_v1/utils/app_style.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {

  final bookingController = Get.put(BookingController());
  final lessonController = Get.put(LessonController());
  final navigationController = Get.put(NavigationController());
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   if (navigationController.catalogIndex != -1) {
    //     int index = bookingController.bookings
    //         .indexWhere((b) => b.id == navigationController.catalogIndex);
    //     scrollController.animateTo(index.toDouble(), duration: const Duration(seconds: 1), curve: const ElasticInCurve());
    //   }
    // });
  }

  Future<List<Lesson>> _getLessons() async{
    List<Lesson> lessons = <Lesson>[];
    await bookingController.getAllBookings(UserController.user.value?.email ?? "stefano.cipolletta@gmail.com");

    for(Booking b in bookingController.bookings){
      Lesson? l = await lessonController.getLesson(b.lesson);
      (l != null) ? lessons.add(l) : null;
    }
    return lessons;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Lesson>>(
      future: _getLessons(),
      builder: (context, snapshot) {

        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(
              color: Styles.orangeColor,
            ),
          );
        }

        if(!snapshot.hasData){
          return const EmptyData(text: "No data found");
        }

        return CustomScrollView(
          controller: scrollController,
          slivers: [
            const SliverAppBar(
              title: Text("FILTRI QUI"),
              pinned: true,
              centerTitle: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(childCount: bookingController.bookings.length,
                    (context, index) {
                  return Obx(() =>
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: CardLesson(bookingController.bookings[index], snapshot.data![index]))
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Gap(AppLayout.initNavigationBarHeight + 10),
            )
          ],
        );
      },
    );
  }
}