import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:progetto_v1/controller/navigation_controller.dart';
import 'package:progetto_v1/controller/user_controller.dart';
import 'package:progetto_v1/db/db_helper.dart';
import 'package:progetto_v1/utils/app_layout.dart';
import 'package:progetto_v1/utils/app_style.dart';
import 'package:progetto_v1/ui/components/custom_bottom_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  final UserController userController = Get.put(UserController());
  late final WebViewController _controller;

  final double _navigationHeight = AppLayout.initNavigationBarHeight;

  @override
  void initState() {
    _controller = WebViewController()
      ..loadFlutterAsset("assets/www/index.html")
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'NewUser',
        onMessageReceived: (message) {
          Map<String, dynamic> json = jsonDecode(message.message);
          userController.login(json["email"], json["password"]);
        },
      );


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Obx(() => userController.user.value != null
          ? Stack(
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
                    size: Size(AppLayout.getSize(context).width, _navigationHeight),
                    painter: CustomPainterBottomBar(),
                  ),
                  SizedBox(
                    width: AppLayout.getSize(context).width,
                    height: AppLayout.initNavigationBarHeight,
                    child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //HOME
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              icon: navigationController.checkIndex(Pages.home)
                                  ? Icon(Ionicons.home, color: Styles.orangeColor,)
                                  : Icon(Ionicons.home_outline, color: Colors.grey.shade400,),
                              onPressed: () => navigationController.currentIndex = Pages.home,
                            ),
                            if (navigationController.checkIndex(Pages.home))
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text("Home", style: Styles.headLineStyle4.copyWith(color: Styles.orangeColor),),
                              )
                          ],
                        ),

                        //SEARCH
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              icon: navigationController.checkIndex(Pages.search)
                                  ? Icon(
                                Ionicons.search,
                                color: Styles.orangeColor,
                              )
                                  : Icon(
                                Ionicons.search_outline,
                                color: Colors.grey.shade400,
                              ),
                              onPressed: () => navigationController.currentIndex = Pages.search,
                            ),
                            if (navigationController.checkIndex(Pages.search))
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  "Search",
                                  style: Styles.headLineStyle4.copyWith(color: Styles.orangeColor),
                                ),
                              )
                          ],
                        ),

                        // CATALOG
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              icon: navigationController.checkIndex(Pages.catalog)
                                  ? Icon(
                                Ionicons.receipt,
                                color: Styles.orangeColor,
                              )
                                  : Icon(
                                Ionicons.receipt_outline,
                                color: Colors.grey.shade400,
                              ),
                              onPressed: () => navigationController.currentIndex = Pages.catalog,
                            ),
                            if (navigationController.checkIndex(Pages.catalog))
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  "Catalog",
                                  style: Styles.headLineStyle4
                                      .copyWith(color: Styles.orangeColor),
                                ),
                              )
                          ],
                        ),

                        // PROFILE
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              icon: navigationController.checkIndex(Pages.profile)
                                  ? Icon(
                                Ionicons.person,
                                color: Styles.orangeColor,
                              )
                                  : Icon(
                                Ionicons.person_outline,
                                color: Colors.grey.shade400,
                              ),
                              onPressed: () => navigationController.currentIndex = Pages.profile,
                            ),
                            if (navigationController.checkIndex(Pages.profile))
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  "Profile",
                                  style: Styles.headLineStyle4.copyWith(color: Styles.orangeColor),
                                ),
                              )
                          ],
                        ),
                      ],
                    )),
                  )
                ],
              ),
            ),
          ),
        ],
      )
          : WebViewWidget(controller: _controller),
      ),
    );
  }
}
