import 'package:brain_saver_flutter/blocs/app/app_bloc.dart';
import 'package:brain_saver_flutter/models/appointment_model.dart';
import 'package:brain_saver_flutter/repositories/schedule_repository.dart';
import 'package:brain_saver_flutter/views/components/components.dart';
import 'package:brain_saver_flutter/views/screens/schedule/cubit/schedule_cubit.dart';
import 'package:brain_saver_flutter/views/screens/schedule/cubit/schedule_form_cubit.dart';
import 'package:brain_saver_flutter/views/screens/schedule/schedule_form.dart';
import 'package:brain_saver_flutter/views/theme/style_const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' as sfCal;

final ScheduleRepository _scheduleRepository = ScheduleRepository();

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc appBloc) => appBloc.state.user);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: BlocProvider(
          create: (_) => ScheduleCubit(
            _scheduleRepository,
            user.id,
          ),
          child: Column(
            children: [
              _Calendar(),
              _AddAppointmentButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Calendar extends StatelessWidget {
  _showDeleteModal(
      BuildContext context, String userId, Appointment appointment) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) {
        return SingleChildScrollView(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              child: const Text(
                'Delete Appointment',
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () => {
                context.read<ScheduleCubit>().deleteAppointment(
                      userId,
                      appointment,
                    ),
                Navigator.pop(context)
              },
            ),
          ),
        );
      },
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(BORDERRADIUS),
          topRight: Radius.circular(BORDERRADIUS),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc appBloc) => appBloc.state.user);
    return BlocBuilder<ScheduleCubit, ScheduleState>(
      buildWhen: (previous, current) =>
          previous.appointments != current.appointments,
      builder: (context, state) {
        return Expanded(
          child: sfCal.SfCalendar(
            view: sfCal.CalendarView.month,
            dataSource: state.appointments,
            monthViewSettings: const sfCal.MonthViewSettings(
              showAgenda: true,
              appointmentDisplayMode:
                  sfCal.MonthAppointmentDisplayMode.indicator,
            ),
            onTap: (sfCal.CalendarTapDetails details) {
              if (details.targetElement == sfCal.CalendarElement.appointment) {
                _showDeleteModal(context, user.id, details.appointments!.first);
              }
            },
          ),
        );
      },
    );
  }
}

class _AddAppointmentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc appBloc) => appBloc.state.user);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButtonValidation(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (_) {
              return _AddAppointmentFormModal();
            },
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(BORDERRADIUS),
                  topRight: Radius.circular(BORDERRADIUS)),
            ),
          ).then((value) => context
              .read<ScheduleCubit>()
              .fetchListAppointmentOfUser(user.id));
        },
        child: const Text('Add Appointment', style: TextStyle(fontSize: 15)),
      ),
    );
  }
}

class _AddAppointmentFormModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScheduleFormCubit(_scheduleRepository),
      child: SingleChildScrollView(
        padding: MediaQuery.of(context).viewInsets,
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: ScheduleForm(),
        ),
      ),
    );
  }
}
