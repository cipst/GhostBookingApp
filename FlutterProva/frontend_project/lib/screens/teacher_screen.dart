import 'package:flutter/material.dart';

class TeacherPage extends StatelessWidget {
  const TeacherPage({super.key, required this.teacher});

  final String teacher;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(teacher),
    );
  }
}
