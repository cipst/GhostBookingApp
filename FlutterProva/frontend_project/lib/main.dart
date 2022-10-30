import 'package:flutter/material.dart';
import 'package:frontend_project/screens/home_screen.dart';
import 'package:frontend_project/screens/splash_screen.dart';
import 'package:frontend_project/utils/app_layout.dart';
import 'package:frontend_project/utils/app_style.dart';
import 'package:frontend_project/utils/painter_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project Frontend',
      theme: ThemeData(
        // primaryColor: Styles.primaryColor,
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Styles.blueColor,
              secondary: Styles.orangeColor,
            ),
      ),
      // home: const SplashPage(),
      home: Root(),
    );
  }
}

class Root extends StatelessWidget {
  Root({super.key});

  final navigationHeight = (80.0).obs;
  final currentPage = 0.obs;
  final pages = [
    const HomePage(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
  ].obs;

  changePage(int newPage) {
    currentPage.value = newPage;
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = AppLayout.getSize(context).height - 80;

    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Stack(
        children: [
          // main page content
          Positioned(
            top: 0,
            left: 0,
            child: Obx(
              () => pages[currentPage.value],
            ),
          ),

          // bottom navigation bar
          Positioned(
            bottom: 0,
            left: 0,
            child: Obx(
              () => SizedBox(
                width: AppLayout.getSize(context).width,
                height: navigationHeight.value,
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(AppLayout.getSize(context).width,
                          navigationHeight.value),
                      painter: CustomPainterBottomBar(),
                    ),
                    GestureDetector(
                      onVerticalDragUpdate: (DragUpdateDetails details) {
                        double positionY = AppLayout.getSize(context).height -
                            details.globalPosition.dy;

                        // limits at 80 height minimum
                        if (positionY < 80) {
                          navigationHeight.value = 80;
                        } else if (positionY <= maxHeight) {
                          navigationHeight.value = positionY;
                        }
                      },
                      child: Center(
                        heightFactor: 0.6,
                        child: FloatingActionButton(
                          backgroundColor: Styles.orangeColor,
                          elevation: 0.1,
                          onPressed: () {
                            if (navigationHeight.value > (maxHeight / 2)) {
                              navigationHeight.value = 80;
                            } else {
                              navigationHeight.value = maxHeight;
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: navigationHeight.value > (maxHeight / 2)
                                ? const Icon(Ionicons.chevron_down)
                                : const Icon(Ionicons.chevron_up),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppLayout.getSize(context).width,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //HOME
                          Obx(
                            () => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  icon: currentPage.value == 0
                                      ? Icon(
                                          Ionicons.home,
                                          color: Styles.orangeColor,
                                        )
                                      : Icon(
                                          Ionicons.home_outline,
                                          color: Colors.grey.shade400,
                                        ),
                                  onPressed: () => changePage(0),
                                ),
                              ],
                            ),
                          ),

                          //SEARCH
                          Obx(
                            () => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  icon: currentPage.value == 1
                                      ? Icon(
                                          Ionicons.search,
                                          color: Styles.orangeColor,
                                        )
                                      : Icon(
                                          Ionicons.search_outline,
                                          color: Colors.grey.shade400,
                                        ),
                                  onPressed: () => changePage(1),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            width: AppLayout.getSize(context).width * 0.20,
                          ),

                          // HISTORY
                          Obx(
                            () => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  icon: currentPage.value == 2
                                      ? Icon(
                                          Ionicons.receipt,
                                          color: Styles.orangeColor,
                                        )
                                      : Icon(
                                          Ionicons.receipt_outline,
                                          color: Colors.grey.shade400,
                                        ),
                                  onPressed: () => changePage(2),
                                ),
                              ],
                            ),
                          ),

                          // PROFILE
                          Obx(
                            () => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  icon: currentPage.value == 3
                                      ? Icon(
                                          Ionicons.person,
                                          color: Styles.orangeColor,
                                        )
                                      : Icon(
                                          Ionicons.person_outline,
                                          color: Colors.grey.shade400,
                                        ),
                                  onPressed: () => changePage(3),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
