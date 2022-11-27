import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:progetto_v1/utils/app_style.dart';

class CustomDialog extends StatelessWidget {
  final String? svgPath;
  final double svgWidth;
  final double svgHeight;
  final Icon icon;
  final String title;
  final Color? titleColor;
  final String description;
  final Text btnText;
  final ButtonStyle? btnStyle;

  const CustomDialog({
    Key? key,
    this.svgPath,
    this.svgWidth = 80,
    this.svgHeight = 80,
    required this.icon,
    required this.title,
    this.titleColor,
    required this.description,
    required this.btnText,
    this.btnStyle,
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
                    Text(title,
                      style: Styles.headLineStyle.copyWith(color: titleColor),
                    ),
                    icon.paddingOnly(bottom: 4),
                  ],
                ),
                const Gap(15),
                Text(description, style: Styles.textStyle, textAlign: TextAlign.center,),
                const Gap(22),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: (){
                      Get.back();
                    },
                    style: btnStyle,
                    child: btnText,
                  ),
                ),
              ],
            ),
          ),
          if(svgPath != null)
            Positioned(
              top: -20,
              left: 1,
              right: 1,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 60,
                child: SvgPicture.asset(
                  svgPath!,
                  width: svgWidth,
                  height: svgHeight,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
