part of 'schedule_cubit.dart';

class ScheduleState extends Equatable {
  final AppointmentDataSource appointments;

  const ScheduleState({required this.appointments});

  @override
  List<Object> get props => [appointments];

  factory ScheduleState.initial() {
    return ScheduleState(
        appointments: AppointmentDataSource(List<Appointment>.empty()));
  }

  ScheduleState copyWith({AppointmentDataSource? appointments}) {
    return ScheduleState(
      appointments: appointments ?? this.appointments,
    );
  }
}
