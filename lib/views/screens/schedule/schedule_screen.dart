import 'package:brain_saver_flutter/blocs/app/app_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: const Alignment(0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Schedule'),
          ],
        ),
      ),
    );
  }
}
