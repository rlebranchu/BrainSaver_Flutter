import 'package:brain_saver_flutter/blocs/app/app_bloc.dart';
import 'package:brain_saver_flutter/models/category_appointment_model.dart';
import 'package:brain_saver_flutter/models/const_models.dart';
import 'package:brain_saver_flutter/views/components/components.dart';
import 'package:brain_saver_flutter/views/screens/schedule/cubit/schedule_form_cubit.dart';
import 'package:brain_saver_flutter/views/theme/style_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleForm extends StatelessWidget {
  const ScheduleForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TitleInput(),
        _CategoryInput(),
        _AllDayCheckBox(),
        BlocBuilder<ScheduleFormCubit, ScheduleFormState>(
          buildWhen: (previous, current) =>
              previous.appointment.isAllDay != current.appointment.isAllDay,
          builder: (context, state) {
            return state.appointment.isAllDay
                ? Container()
                : Column(
                    children: [
                      const SizedBox(height: 13),
                      _StartTimePicker(),
                      const SizedBox(height: 13),
                      _EndTimePicker(),
                    ],
                  );
          },
        ),
        const SizedBox(height: 13),
        _SaveButton()
      ],
    );
  }
}

class _TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleFormCubit, ScheduleFormState>(
      buildWhen: (previous, current) =>
          previous.appointment.eventName != current.appointment.eventName,
      builder: (context, state) {
        return TextFieldApp(
            label: 'Name of appointment',
            initialValue: state.appointment.eventName,
            onChange: (appointmentName) => context
                .read<ScheduleFormCubit>()
                .appointmentNameChanged(appointmentName),
            textAlign: TextAlign.center);
      },
    );
  }
}

class _CategoryInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Category: '),
        const SizedBox(width: 20),
        BlocBuilder<ScheduleFormCubit, ScheduleFormState>(
          buildWhen: (previous, current) =>
              previous.appointment.category != current.appointment.category,
          builder: (context, state) {
            return DropdownButton(
              // Initial Value
              value: state.appointment.category,
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),
              // Array list of items
              items: CATEGORYCOLOR.map((CategoryAppointment items) {
                return DropdownMenuItem(
                  value: items.name,
                  child: Text(items.name),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newCategory) => context
                  .read<ScheduleFormCubit>()
                  .categoryChanged(newCategory!),
            );
          },
        ),
      ],
    );
  }
}

class _AllDayCheckBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleFormCubit, ScheduleFormState>(
      buildWhen: (previous, current) =>
          previous.appointment.isAllDay != current.appointment.isAllDay,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('All Day :'),
            Checkbox(
              value: state.appointment.isAllDay,
              activeColor: PRIMARYCOLOR,
              onChanged: (allDay) =>
                  context.read<ScheduleFormCubit>().allDayChanged(allDay!),
            ),
          ],
        );
      },
    );
  }
}

class _StartTimePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleFormCubit, ScheduleFormState>(
      buildWhen: (previous, current) =>
          previous.appointment.from != current.appointment.from,
      builder: (context, state) {
        return DatePickerApp(
          label: 'Start Time',
          onChange: (newDateTime) =>
              context.read<ScheduleFormCubit>().startTimeChanged(newDateTime),
          value: state.appointment.from,
        );
      },
    );
  }
}

class _EndTimePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleFormCubit, ScheduleFormState>(
      buildWhen: (previous, current) =>
          previous.appointment.to != current.appointment.to,
      builder: (context, state) {
        return DatePickerApp(
          label: 'End Time',
          onChange: (newDateTime) =>
              context.read<ScheduleFormCubit>().endTimeChanged(newDateTime),
          value: state.appointment.to,
        );
      },
    );
  }
}

class _SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc appBloc) => appBloc.state.user);
    return BlocBuilder<ScheduleFormCubit, ScheduleFormState>(
      buildWhen: (previous, current) =>
          previous.appointment.eventName != current.appointment.eventName,
      builder: (context, state) {
        return state.appointment.eventName.isEmpty
            ? Container()
            : ElevatedButtonValidation(
                child: const Text('Save Appointment',
                    style: TextStyle(fontSize: 15)),
                onPressed: () => {
                  context.read<ScheduleFormCubit>().saveAppointment(user.id),
                  Navigator.pop(context)
                },
              );
      },
    );
  }
}
