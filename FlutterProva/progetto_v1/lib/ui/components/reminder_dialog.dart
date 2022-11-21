import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:progetto_v1/utils/app_style.dart';

class ReminderDialog extends StatefulWidget {
  final TextEditingController controller;
  const ReminderDialog({Key? key, required this.controller}) : super(key: key);

  @override
  State<ReminderDialog> createState() => _ReminderDialogState();
}

class _ReminderDialogState extends State<ReminderDialog> {

  int _minutesEarly = 5;
  String? _errorText;

  _changeMinutes(String newValue){
    debugPrint("VALUE: $newValue");

    if(newValue.isEmpty) {
      setState(() {
        _errorText = "Enter a valid number";
      });
      return;
    }

    int v = int.parse(newValue);

    setState(() {
      _minutesEarly = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 50,
          child: TextField(
            controller: widget.controller,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: "5",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Styles.blueColor
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Styles.blueColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Styles.errorColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: _changeMinutes,
            onSubmitted: _changeMinutes,
            keyboardType: const TextInputType.numberWithOptions(decimal: false),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),

        const Gap(8),
        _minutesEarly > 1 ? const Text("minutes early") : const Text("minute early"),
      ],
    );
  }
}
