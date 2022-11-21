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

  int _minutesBefore = 5;


  _changeMinutes(String newValue){
    if(newValue.isEmpty) return;
    setState(() {
      _minutesBefore = int.parse(newValue);
    });

    widget.controller.text = newValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 50,
          height: 50,
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
                    color: Styles.blueColor
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: _changeMinutes,
            onSubmitted: _changeMinutes,
            keyboardType: const TextInputType.numberWithOptions(decimal: false),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
        const Gap(8),
        _minutesBefore > 1 ? const Text("minutes before") : const Text("minute before"),
      ],
    );
  }
}
