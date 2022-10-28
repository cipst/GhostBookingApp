import 'package:flutter/material.dart';

class LearnFlutterPage extends StatefulWidget {
  const LearnFlutterPage({super.key});

  @override
  State<LearnFlutterPage> createState() => _LearnFlutterPageState();
}

class _LearnFlutterPageState extends State<LearnFlutterPage> {
  bool isSwitch = false;
  bool? isCheckbox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: const Text("Learning Flutter"),
        automaticallyImplyLeading:
            false, //this param will remove the "back" icon to go back to the previous page in the top bar
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("images/sium.gif"),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.red,
            ),
            Container(
              color: Colors.blue,
              width: double.infinity,
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              child: const Center(
                child: Text(
                  "This is a text widget",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isSwitch ? Colors.purple : Colors.blue,
              ),
              onPressed: () {
                debugPrint("Elevated Button");
              },
              child: const Text(
                "Elevated Button",
              ),
            ),
            OutlinedButton(
              onPressed: () {
                debugPrint("Outlined Button");
              },
              child: const Text(
                "Outlined Button",
              ),
            ),
            TextButton(
              onPressed: () {
                debugPrint("Text Button");
              },
              child: const Text(
                "Text Button",
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                debugPrint("This is the row");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.blue,
                  ),
                  Text("Row Widget"),
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            Switch(
              value: isSwitch,
              onChanged: (bool newBool) {
                setState(() {
                  isSwitch = newBool;
                });
              },
            ),
            Checkbox(
              value: isCheckbox,
              onChanged: (bool? newBool) {
                setState(() {
                  isCheckbox = newBool;
                });
              },
            ),
            Image.network(
                "https://c.tenor.com/pkIQCK68Y3wAAAAM/ronaldo-sium-ronaldo-siuuu.gif"),
          ],
        ),
      ),
    );
  }
}
