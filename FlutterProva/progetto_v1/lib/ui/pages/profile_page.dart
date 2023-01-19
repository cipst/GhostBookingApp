import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progetto_v1/controller/user_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(UserController.user.value?.name ?? "NAME"),
          Text(UserController.user.value?.email ?? "EMAIL"),
          Text(UserController.user.value?.phone ?? "PHONE"),
          ElevatedButton(onPressed: () => userController.logout(), child: const Text("Logout")),
        ]
    ),
    );
  }
}