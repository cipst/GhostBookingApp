import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart'; // package for slidable item

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // backgroundColor: Colors.black87,
      color: Colors.black87,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Slidable(
            key: ValueKey(index),
            closeOnScroll: true,
            child: ListTile(
              title: Text(
                "Item $index",
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
