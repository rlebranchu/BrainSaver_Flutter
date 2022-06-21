import 'package:flutter/material.dart';

// Custom TextFormField to assign shadow  to standard TextField Flutter Component
class TextFormFieldApp extends StatelessWidget {
  final String label;
  final Function onChange;
  final IconData? icon;
  final String? initialValue;
  final bool obscureText;
  final bool enableSuggestions;

  const TextFormFieldApp(
      {Key? key,
      required this.label,
      required this.onChange,
      this.icon,
      this.initialValue,
      this.obscureText = false,
      this.enableSuggestions = false})
      : super(key: key);

  void onChanged(value) {
    onChange(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          prefixIcon: Icon(icon),
          labelText: label,
        ),
        obscureText: obscureText,
        enableSuggestions: enableSuggestions,
      ),
    );
  }
}
