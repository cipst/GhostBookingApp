import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:frontend_project/utils/app_layout.dart';
import 'package:frontend_project/utils/app_style.dart';
import 'package:ionicons/ionicons.dart';

class CardUpcomingLesson extends StatelessWidget {
  final double cardWidth;
  final bool hasMargRight;

  final String subject;
  final String teacher;
  final String image;
  final String time;
  final String day;
  final void Function() onTap;

  const CardUpcomingLesson({
    super.key,
    this.cardWidth = 0.80,
    this.hasMargRight = true,
    required this.subject,
    required this.teacher,
    required this.image,
    required this.time,
    required this.day,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // size of the context
    final size = AppLayout.getSize(context);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size.width * cardWidth,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          margin: (hasMargRight)
              ? const EdgeInsets.only(right: 20)
              : const EdgeInsets.only(right: 0),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 80,
                height: 80,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(image),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teacher,
                    style: Styles.headLineStyle2.copyWith(color: Colors.black),
                  ),
                  const Gap(8),
                  Text(
                    subject,
                    style: Styles.textStyle,
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            size: 15,
                          ),
                          const Gap(4),
                          Text(day)
                        ],
                      ),
                      const Gap(20),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_outlined,
                            size: 15,
                          ),
                          const Gap(4),
                          Text(time)
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
