import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progetto_v1/model/appointment.dart';
import 'package:progetto_v1/model/lesson.dart';
import 'package:progetto_v1/model/teacher.dart';
import 'package:progetto_v1/ui/components/card_search.dart';
import 'package:progetto_v1/utils/app_layout.dart';
import 'package:progetto_v1/utils/app_style.dart';

enum CatalogType { date, teacher, subject }

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  CatalogType _currentCatalog = CatalogType.date;
  DateTime _selectedDate = DateTime.now();

  set currentCatalog(CatalogType newCatalog) {
    setState(() {
      _currentCatalog = newCatalog;
    });
  }

  bool isCurrentCatalog(CatalogType checkCatalog) {
    return _currentCatalog == checkCatalog;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: _catalogTabBar(),
          backgroundColor: Styles.bgColor,
          shadowColor: Colors.transparent,
          snap: true,
          floating: true,
        ),
        if (isCurrentCatalog(CatalogType.date))
          SliverAppBar(
            title: _datePicker(),
            centerTitle: true,
            toolbarHeight: 100,
            backgroundColor: Styles.bgColor,
            pinned: true,
          ),
        _catalogList(),
        SliverToBoxAdapter(
          child: Gap(AppLayout.initNavigationBarHeight + 5),
        )
      ],
    );

    // const Gap(90),
  }

  Container _catalogTabBar() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => currentCatalog = CatalogType.date,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: isCurrentCatalog(CatalogType.date)
                    ? Styles.orangeColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Styles.orangeColor),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6, right: 8),
                    child: Icon(
                      Ionicons.calendar_outline,
                      color: isCurrentCatalog(CatalogType.date)
                          ? Colors.white
                          : Styles.orangeColor,
                    ),
                  ),
                  Text(
                    "Date",
                    style: Styles.textStyle.copyWith(
                        color: isCurrentCatalog(CatalogType.date)
                            ? Colors.white
                            : Styles.orangeColor),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => currentCatalog = CatalogType.teacher,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: isCurrentCatalog(CatalogType.teacher)
                    ? Styles.orangeColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Styles.orangeColor),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6, right: 8),
                    child: Icon(
                      Ionicons.glasses_outline,
                      color: isCurrentCatalog(CatalogType.teacher)
                          ? Colors.white
                          : Styles.orangeColor,
                    ),
                  ),
                  Text(
                    "Teacher",
                    style: Styles.textStyle.copyWith(
                        color: isCurrentCatalog(CatalogType.teacher)
                            ? Colors.white
                            : Styles.orangeColor),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => currentCatalog = CatalogType.subject,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: isCurrentCatalog(CatalogType.subject)
                    ? Styles.orangeColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Styles.orangeColor),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6, right: 8),
                    child: Icon(
                      Ionicons.book_outline,
                      color: isCurrentCatalog(CatalogType.subject)
                          ? Colors.white
                          : Styles.orangeColor,
                    ),
                  ),
                  Text(
                    "Subject",
                    style: Styles.textStyle.copyWith(
                        color: isCurrentCatalog(CatalogType.subject)
                            ? Colors.white
                            : Styles.orangeColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _catalogList() {
    if (isCurrentCatalog(CatalogType.date)) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return CardSearch(
              Appointment(Lesson.list[index], DateTime.now()),
            );
          },
          childCount: Lesson.list.length,
        ),
      );
    } else if (isCurrentCatalog(CatalogType.teacher)) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Center(child: Text(Teacher.list[index].name!));
          },
          childCount: Teacher.list.length,
        ),
      );
    } else {
      return const SliverToBoxAdapter(
        child: Text("Subject"),
      );
    }
  }

  Widget _datePicker() {
    return DatePicker(
      DateTime.now(),
      height: 100,
      width: 70,
      daysCount: 7,
      initialSelectedDate: DateTime.now(),
      selectionColor: Styles.blueColor,
      dayTextStyle: Styles.headLineStyle2
          .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
      dateTextStyle: Styles.headLineStyle.copyWith(color: Colors.black),
      monthTextStyle: Styles.headLineStyle4
          .copyWith(color: Colors.black, fontWeight: FontWeight.normal),
      onDateChange: (selectedDate) {
        setState(() {
          _selectedDate = selectedDate;
        });
      },
    );
  }
}
