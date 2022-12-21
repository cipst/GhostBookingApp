import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progetto_v1/controller/navigation_controller.dart';
import 'package:progetto_v1/db/db_helper.dart';
import 'package:progetto_v1/utils/app_layout.dart';
import 'package:progetto_v1/utils/app_style.dart';
import 'package:progetto_v1/ui/components/custom_bottom_bar.dart';
import 'package:progetto_v1/utils/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  await DBHelper.instance.database;

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ghost Booking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Styles.blueColor,
                secondary: Styles.orangeColor,
              ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )))),
      home: const Root(),
    );
  }
}

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  final navigationController = Get.put(NavigationController());

  double _navigationHeight = AppLayout.initNavigationBarHeight;

  void _updateNavigationHeight(double newHeight) {
    setState(() {
      _navigationHeight = newHeight;
    });
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
            child: SizedBox(
              width: AppLayout.getSize(context).width,
              height: AppLayout.getSize(context).height,
              child: Obx(() => navigationController.currentPage),
            ),
          ),

          // bottom navigation bar
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: AppLayout.getSize(context).width,
              height: _navigationHeight,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(
                        AppLayout.getSize(context).width, _navigationHeight),
                    painter: CustomPainterBottomBar(),
                  ),
                  GestureDetector(
                    onVerticalDragUpdate: (DragUpdateDetails details) {
                      double positionY = AppLayout.getSize(context).height -
                          details.globalPosition.dy;

                      // limits at 80 height minimum
                      if (positionY < 80) {
                        _updateNavigationHeight(80.0);
                      } else if (positionY <= maxHeight) {
                        _updateNavigationHeight(positionY);
                      }
                    },
                    child: Center(
                      heightFactor: 0.6,
                      child: FloatingActionButton(
                        backgroundColor: Styles.orangeColor,
                        elevation: 0.1,
                        onPressed: () {
                          if (_navigationHeight > (maxHeight / 2)) {
                            _updateNavigationHeight(80.0);
                          } else {
                            _updateNavigationHeight(maxHeight);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: _navigationHeight > (maxHeight / 2)
                              ? const Icon(Ionicons.chevron_down)
                              : const Icon(Ionicons.chevron_up),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppLayout.getSize(context).width,
                    height: 80,
                    child: Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //HOME
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  icon: navigationController
                                          .checkIndex(Pages.home)
                                      ? Icon(
                                          Ionicons.home,
                                          color: Styles.orangeColor,
                                        )
                                      : Icon(
                                          Ionicons.home_outline,
                                          color: Colors.grey.shade400,
                                        ),
                                  onPressed: () => navigationController
                                      .currentIndex = Pages.home,
                                ),
                                if (navigationController.checkIndex(Pages.home))
                                  Text(
                                    "Home",
                                    style: Styles.headLineStyle4
                                        .copyWith(color: Styles.orangeColor),
                                  )
                              ],
                            ),

                            //SEARCH
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  icon: navigationController
                                          .checkIndex(Pages.search)
                                      ? Icon(
                                          Ionicons.search,
                                          color: Styles.orangeColor,
                                        )
                                      : Icon(
                                          Ionicons.search_outline,
                                          color: Colors.grey.shade400,
                                        ),
                                  onPressed: () => navigationController
                                      .currentIndex = Pages.search,
                                ),
                                if (navigationController
                                    .checkIndex(Pages.search))
                                  Text(
                                    "Search",
                                    style: Styles.headLineStyle4
                                        .copyWith(color: Styles.orangeColor),
                                  )
                              ],
                            ),

                            Container(
                              width: AppLayout.getSize(context).width * 0.20,
                            ),

                            // CATALOG
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  icon: navigationController
                                          .checkIndex(Pages.catalog)
                                      ? Icon(
                                          Ionicons.receipt,
                                          color: Styles.orangeColor,
                                        )
                                      : Icon(
                                          Ionicons.receipt_outline,
                                          color: Colors.grey.shade400,
                                        ),
                                  onPressed: () => navigationController
                                      .currentIndex = Pages.catalog,
                                ),
                                if (navigationController
                                    .checkIndex(Pages.catalog))
                                  Text(
                                    "Catalog",
                                    style: Styles.headLineStyle4
                                        .copyWith(color: Styles.orangeColor),
                                  )
                              ],
                            ),

                            // PROFILE
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  icon: navigationController
                                          .checkIndex(Pages.profile)
                                      ? Icon(
                                          Ionicons.person,
                                          color: Styles.orangeColor,
                                        )
                                      : Icon(
                                          Ionicons.person_outline,
                                          color: Colors.grey.shade400,
                                        ),
                                  onPressed: () => navigationController
                                      .currentIndex = Pages.profile,
                                ),
                                if (navigationController
                                    .checkIndex(Pages.profile))
                                  Text(
                                    "Profile",
                                    style: Styles.headLineStyle4
                                        .copyWith(color: Styles.orangeColor),
                                  )
                              ],
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
