import 'package:brain_saver_flutter/views/theme/style_const.dart';
import 'package:flutter/material.dart';

class ElevatedButtonValidation extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  const ElevatedButtonValidation(
      {Key? key, required this.child, required this.onPressed})
      : super(key: key);

  void onPress() {
    onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: child,
      style: ElevatedButton.styleFrom(
        primary: PRIMARYCOLOR,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BORDERRADIUS),
        ),
        textStyle: const TextStyle(fontSize: 19.0, fontFamily: 'Montserrat'),
      ),
    );
  }
}
