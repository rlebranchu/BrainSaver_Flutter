import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// Component DatePicker
class DatePickerApp extends StatelessWidget {
  final String label;
  final Function onChange;
  final DateTime value;

  const DatePickerApp({
    Key? key,
    required this.label,
    required this.onChange,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(label),
        TextButton(
          onPressed: () {
            // Function launch to show bottom modal with date time formular
            DatePicker.showDateTimePicker(
              context,
              showTitleActions: true,
              onConfirm: (date) => onChange(date),
              currentTime: value,
            );
          },
          child: Text(
            DateFormat("yyyy-MM-dd HH:mm:ss").format(value),
          ),
        ),
      ],
    );
  }
}
