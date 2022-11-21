import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progetto_v1/utils/app_layout.dart';
import 'package:progetto_v1/utils/app_style.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  String _currentCatalog = "date";

  changeCurrentCatalog(String newCatalog) {
    setState((){
      _currentCatalog = newCatalog;
    });
  }

  bool isCurrentCatalog(String checkCatalog) {
    return _currentCatalog == checkCatalog;
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
  @override
  Widget build(BuildContext context) {
    return Column(
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
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _catalogTabBar(),
            ),
          ),
          SizedBox(
            width: AppLayout.getSize(context).width,
            child: _catalogList(),
          ),
        ],
      );

    // const Gap(90),
  }
}
