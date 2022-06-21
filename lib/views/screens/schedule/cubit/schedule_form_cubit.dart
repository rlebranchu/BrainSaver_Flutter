import 'package:bloc/bloc.dart';
import 'package:brain_saver_flutter/models/appointment_model.dart';
import 'package:brain_saver_flutter/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'schedule_form_state.dart';

class ScheduleFormCubit extends Cubit<ScheduleFormState> {
  final ScheduleRepository _scheduleRepository;

  ScheduleFormCubit(this._scheduleRepository)
      : super(ScheduleFormState.initial());

  // Reset values of state -> re-initalize state
  void resetForm() {
    emit(ScheduleFormState.initial());
  }

  // New state : with the new value of event Name
  void appointmentNameChanged(String eventName) {
    Appointment _appointment =
        state.appointment.setAttribut(eventName: eventName);
    emit(state.copyWith(appointment: _appointment));
  }

  // New state : with the new value of category
  void categoryChanged(String _category) {
    Appointment _appointment =
        state.appointment.setAttribut(category: _category);
    emit(state.copyWith(appointment: _appointment));
  }

  // New state : with the new value of isAllDay
  void allDayChanged(bool allDay) {
    Appointment _appointment = state.appointment.setAttribut(isAllDay: allDay);
    emit(state.copyWith(appointment: _appointment));
  }

  // New state : with the new value of start datetime
  void startTimeChanged(DateTime newDateTime) {
    Appointment _appointment = state.appointment.setAttribut(from: newDateTime);
    emit(state.copyWith(appointment: _appointment));
  }

  // New state : with the new value of end datetime
  void endTimeChanged(DateTime newDateTime) {
    Appointment _appointment = state.appointment.setAttribut(to: newDateTime);
    emit(state.copyWith(appointment: _appointment));
  }

  // ASk to service to create a new appointment for the user logged
  void saveAppointment(String userId) {
    _scheduleRepository.saveAppointment(userId, state.appointment);
    resetForm();
  }
}
