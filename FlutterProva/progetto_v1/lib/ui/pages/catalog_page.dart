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

  _scrollFunction()
  {
    bool retry = true;
    GlobalKey k;
    int index = navigationController.catalogIndexToScroll;
    do{
      k = bookingController.keys.elementAt(index) as GlobalKey;
      if (k.currentContext != null) {
        Scrollable.ensureVisible(
          k.currentContext!,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuad,
        );
        retry = false;
      } else {
        if (index > 0) {
          index--;
        }else{
          retry = false;
        }
      }
    }while(retry);
    navigationController.catalogIndexToScroll = 0; //reset scroll index to 0
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollFunction());

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
                          key: bookingController.keys[index],
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