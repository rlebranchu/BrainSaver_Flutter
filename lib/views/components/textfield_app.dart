import 'package:flutter/material.dart';

// Custom TextField to assign shadow  to standard TextField Flutter Component
class TextFieldApp extends StatelessWidget {
  final String label;
  final Function onChange;
  final String? initialValue;
  final bool obscureText;
  final bool enableSuggestions;
  final TextAlign textAlign;

  const TextFieldApp(
      {Key? key,
      required this.label,
      required this.onChange,
      this.initialValue,
      this.obscureText = false,
      this.enableSuggestions = false,
      this.textAlign = TextAlign.left})
      : super(key: key);

  void onChanged(value) {
    onChange(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Add Shadow to Input
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: const Offset(1.4, 1.4),
              blurRadius: 10.0),
        ],
      ),
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: label,
        ),
        style: Theme.of(context).textTheme.headline2,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        obscureText: obscureText,
        enableSuggestions: enableSuggestions,
      ),
    );
  }
}
