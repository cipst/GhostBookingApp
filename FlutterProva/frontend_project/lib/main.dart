import 'package:flutter/material.dart';
import 'package:frontend_project/screens/splash_screen.dart';
import 'package:frontend_project/utils/app_style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project Frontend',
      theme: ThemeData(
        primaryColor: Styles.primaryColor,
      ),
      home: const SplashPage(),
    );
  }
}

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("ROOT"),),
    );
  }
}
