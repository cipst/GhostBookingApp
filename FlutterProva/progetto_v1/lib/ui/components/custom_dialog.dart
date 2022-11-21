import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:progetto_v1/utils/app_layout.dart';

class CustomDialog extends StatelessWidget {
  final Icon type;
  final String title;
  final String description;
  final String btnText;

  const CustomDialog({
    Key? key,
    required this.type,
    required this.title,
    required this.description,
    required this.btnText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
                left: 20,
                top: 45+20,
                right: 20,
                bottom: 20
            ),
            margin: const EdgeInsets.only(top: 45),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Colors.black,offset: Offset(0,10),
                      blurRadius: 10
                  ),
                ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    type.paddingOnly(bottom: 4),
                    Text(title, style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                  ],
                ),
                const Gap(15),
                Text(description, style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
                const Gap(22),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: (){
                        Get.back();
                      },
                      child: Text(btnText, style: TextStyle(fontSize: 18),)),
                ),
              ],
            ),
          ),
          Positioned(
            left: 1,
            right: 1,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 45,
              child: SvgPicture.asset(
                "assets/illustrations/clock.svg",
                semanticsLabel: "Reminder",
                width: 200,
                height: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
