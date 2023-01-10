import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:progetto_v1/ui/pages/catalog_page.dart';
import 'package:progetto_v1/ui/pages/home_page.dart';
import 'package:progetto_v1/ui/pages/profile_page.dart';
import 'package:progetto_v1/ui/pages/search_page.dart';

enum Pages { home, search, catalog, profile }

class NavigationController extends GetxController {
  final _currentIndex = Pages.home.obs;
  final _catalogIndex = (-1).obs;

  final List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const CatalogPage(),
    const ProfilePage(),
  ];

  Pages get currentIndex => _currentIndex.value;
  set currentIndex(Pages newPage) => _currentIndex.value = newPage;

  Widget get currentPage => pages[currentIndex.index];

  bool checkIndex(Pages index) {
    return currentIndex == index;
  }

  int get catalogIndex => _catalogIndex.value;
  set catalogIndex(int index) => _catalogIndex.value = index;
}
