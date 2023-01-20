import 'package:flutter/material.dart';
import 'package:progetto_v1/utils/app_style.dart';

class SpecialPage extends StatelessWidget {
  const SpecialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App information"),
      ),
      body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    scale: 1,
                    image: AssetImage("assets/book.png"),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("App Name", style: Styles.headLineStyle4),
                  Text("Ghost Booking", style: Styles.textStyle)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("App Creator", style: Styles.headLineStyle4),
                  Text("Stefano Cipolletta", style: Styles.textStyle)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("University Email", style: Styles.headLineStyle4),
                  Text("stefano.cipolletta@edu.unito.it", style: Styles.textStyle)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Badge Number", style: Styles.headLineStyle4),
                  Text("948650", style: Styles.textStyle)
                ],
              )
            ],
          )
      ),
    );
  }
}
