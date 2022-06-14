part of 'schedule_form_cubit.dart';

class ScheduleFormState extends Equatable {
  final Appointment appointment;

  const ScheduleFormState({required this.appointment});

  @override
  List<Object> get props => [appointment];

  factory ScheduleFormState.initial() {
    return ScheduleFormState(appointment: Appointment.empty);
  }

  ScheduleFormState copyWith({Appointment? appointment}) {
    return ScheduleFormState(
      appointment: appointment ?? this.appointment,
    );
  }
}
