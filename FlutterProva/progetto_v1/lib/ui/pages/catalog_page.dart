import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:progetto_v1/controller/booking_controller.dart';
import 'package:progetto_v1/controller/lesson_controller.dart';
import 'package:progetto_v1/controller/navigation_controller.dart';
import 'package:progetto_v1/ui/components/card_lesson.dart';
import 'package:progetto_v1/ui/components/empty_data.dart';
import 'package:progetto_v1/utils/app_layout.dart';

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
    bookingController.getAllBookings("stefano.cipolletta@gmail.com");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text("FILTRI QUI"),
              pinned: true,
              centerTitle: true,
            ),
            bookingController.bookings.isEmpty ?
            SliverToBoxAdapter(
              child: Container(
                  margin: const EdgeInsets.only(top: 70),
                  child: const EmptyData(text: "No lessons in the catalog")
              ),
            )
                :
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: bookingController.bookings.length,
                      (context, index){
                    return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: CardLesson(
                          bookingController.bookings[index],
                          bookingController.lessons[index],
                          getAll: true,
                        )
                    );
                  }),
            ),
            SliverToBoxAdapter(
              child: Gap(AppLayout.initNavigationBarHeight + 10),
            )
          ],
        )
    );
  }
}