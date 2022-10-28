import 'package:flutter/material.dart';
import 'package:progetto_v0/HomePage.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Progetto v0",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const Root(),
    );
  }
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _currentPage = 0;
  List<Widget> pages = const [
    HomePage(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Progetto v0"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_rounded),
          ),
        ],
      ),
      body: pages[_currentPage],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentPage,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.search_rounded),
            label: "Search",
          ),
        ],
        onDestinationSelected: (int newPage) {
          setState(() {
            _currentPage = newPage;
          });
        },
      ),
    );
  }
}
