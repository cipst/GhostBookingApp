import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:progetto_v1/utils/app_style.dart';

class EmptyData extends StatelessWidget {
  final String text;
  const EmptyData({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(40),
        Center(
          child: SvgPicture.asset(
            "assets/illustrations/no_data.svg",
            semanticsLabel: text,
            width: 200,
            height: 200,
          ),
        ),
        const Gap(40),
        Text(text, style: Styles.headLineStyle2,)
      ],
    );
  }
}
