import 'package:flutter/material.dart';
import 'package:tutorial/home_page.dart';
import 'package:tutorial/profile_page.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentPage = 0;
  List<Widget> pages = const [
    HomePage(),
    ProfilePage(),
    ProfilePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter First Tutorial"),
      ),
      body: pages[_currentPage],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Floating Action Button");
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return const HomePage();
            }),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.search_rounded),
            label: "Search",
          ),
          NavigationDestination(
            icon: Icon(Icons.history_rounded),
            label: "History",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_rounded),
            label: "Profile",
          ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            _currentPage = index;
          });
        },
        selectedIndex: _currentPage,
      ),
    );
  }
}
