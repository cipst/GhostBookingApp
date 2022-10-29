import 'package:flutter/material.dart';
import 'package:frontend_project/utils/app_layout.dart';
import 'package:frontend_project/utils/app_style.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppLayout.getSize(context).width,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          //HEADER
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome!",
                    style: Styles.headLineStyle4,
                  ),
                  Text(
                    "Stefano",
                    style: Styles.headLineStyle,
                  ),
                ],
              ),
              Expanded(child: Container()),
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    scale: 9,
                    image: AssetImage("book.png"),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
