import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:progetto_v1/controller/booking_controller.dart';
import 'package:progetto_v1/controller/lesson_controller.dart';
import 'package:progetto_v1/controller/navigation_controller.dart';
import 'package:progetto_v1/model/booking.dart';
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
    bookingController.getAllBookings("stefano.cipolletta@gmail.com");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return
      CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                backgroundColor: MaterialStatePropertyAll(Colors.white),
                                side: MaterialStatePropertyAll(BorderSide(color: Styles.successColor))
                            ),
                            onPressed: () => _getByStatus(StatusType.active),
                            child: Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Styles.successColor,
                                    ),
                                  ),
                                  const Gap(8),
                                  Text("Active", style: Styles.headLineStyle4.copyWith(
                                      color: Styles.successColor
                                  ),),
                                ]
                            ),
                          )
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                backgroundColor: MaterialStatePropertyAll(Colors.white),
                                side: MaterialStatePropertyAll(BorderSide(color: Styles.errorColor))
                            ),
                            onPressed: () => _getByStatus(StatusType.complete),
                            child: Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Styles.errorColor,
                                    ),
                                  ),
                                  const Gap(8),
                                  Text("Completed", style: Styles.headLineStyle4.copyWith(
                                      color: Styles.errorColor
                                  ),),
                                ]
                            ),
                          )
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                backgroundColor: MaterialStatePropertyAll(Colors.white),
                                side: MaterialStatePropertyAll(BorderSide(color: Styles.greyColor))
                            ),
                            onPressed: () => _getByStatus(StatusType.cancel),
                            child: Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Styles.greyColor,
                                    ),
                                  ),
                                  const Gap(8),
                                  Text("Cancelled", style: Styles.headLineStyle4.copyWith(
                                      color: Styles.greyColor
                                  ),),
                                ]
                            ),
                          )
                      ),
                    ]
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 10),
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                                      side: MaterialStatePropertyAll(BorderSide(color: Styles.successColor))
                                  ),
                                  onPressed: () => null,
                                  child: Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Styles.successColor,
                                          ),
                                        ),
                                        const Gap(8),
                                        Text("Active", style: Styles.headLineStyle4.copyWith(
                                            color: Styles.successColor
                                        ),),
                                      ]
                                  ),
                                )
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 10),
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                                      side: MaterialStatePropertyAll(BorderSide(color: Styles.errorColor))
                                  ),
                                  onPressed: () => null,
                                  child: Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Styles.errorColor,
                                          ),
                                        ),
                                        const Gap(8),
                                        Text("Completed", style: Styles.headLineStyle4.copyWith(
                                            color: Styles.errorColor
                                        ),),
                                      ]
                                  ),
                                )
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 10),
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                                      side: MaterialStatePropertyAll(BorderSide(color: Styles.greyColor))
                                  ),
                                  onPressed: () => null,
                                  child: Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Styles.greyColor,
                                          ),
                                        ),
                                        const Gap(8),
                                        Text("Cancelled", style: Styles.headLineStyle4.copyWith(
                                            color: Styles.greyColor
                                        ),),
                                      ]
                                  ),
                                )
                            ),
                          ]
                      ),
                    ],
                  ),
                ),
              ],
            ),
            centerTitle: true,
            floating: true,
            backgroundColor: Colors.white,
            toolbarHeight: 120,
          ),
          Obx(() =>
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
          )

          ),
          SliverToBoxAdapter(
            child: Gap(AppLayout.initNavigationBarHeight + 10),
          )
        ],
      );
  }

  void _getByStatus(StatusType status) {
    debugPrint("STATUS INDEX: ${status.index}");
    bookingController.getBookingByStatus("stefano.cipolletta@gmail.com", status);
  }
}