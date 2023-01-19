import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progetto_v1/controller/user_controller.dart';
import 'package:progetto_v1/utils/app_layout.dart';
import 'package:progetto_v1/utils/app_style.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserController userController = Get.put(UserController());

  _updateImage() async {
    if((userController.user.value?.image != null && (userController.user.value?.image)!.isNotEmpty)){
      userController.updateImage("");
      userController.user.value!.image = "";
      setState(() {});
      return;
    }

    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(image == null) return;

    final String path = (await getApplicationDocumentsDirectory()).path;

    final fileName = basename(image.path);

    await File(image.path).copy('$path/$fileName');

    userController.updateImage('$path/$fileName');
    userController.user.value!.image = '$path/$fileName';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("QUI - BUILD PROFILE PAGE");

    return Obx(() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            children: [
              _avatar(),
              Positioned(
                right: 10,
                bottom: 10,
                child: GestureDetector(
                    onTap: () => _updateImage(),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: (userController.user.value?.image != null && (userController.user.value?.image)!.isNotEmpty)
                          ? const Icon(Ionicons.close_outline, size: 30,)
                          : const Icon(Ionicons.camera_outline, size: 30,),
                    )
                ),
              )
            ],
          ),
          Text(userController.user.value!.name, style: Styles.headLineStyle,),
          Text(userController.user.value!.email, style: Styles.headLineStyle2,),
          Text("+${userController.user.value!.phone}", style: Styles.headLineStyle3,),
          ElevatedButton(onPressed: () => userController.logout(), child: const Text("Logout")),
          Gap(AppLayout.initNavigationBarHeight),
        ]
    ),
    );
  }

  CircleAvatar _avatar() {
    return CircleAvatar(
      backgroundColor: Styles.orangeColor,
      radius: 110,
      child: CircleAvatar(
        backgroundColor: Styles.bgColor,
        radius: 108,
        child: Center(
          child: CircleAvatar(
            backgroundColor: Styles.bgColor,
            radius: 95,
            foregroundImage: (userController.user.value!.image != null && userController.user.value!.image!.isNotEmpty)
                ? FileImage(File(userController.user.value!.image!))
                : null,
            child: !(userController.user.value!.image != null && userController.user.value!.image!.isNotEmpty)
                ? Image.asset("assets/images/default.png")
                : null,
          ),
        ),
      ),
    );
  }
}