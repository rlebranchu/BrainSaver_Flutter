import 'package:bloc/bloc.dart';
import 'package:brain_saver_flutter/models/appointment_model.dart';
import 'package:brain_saver_flutter/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'schedule_form_state.dart';

class ScheduleFormCubit extends Cubit<ScheduleFormState> {
  final ScheduleRepository _scheduleRepository;

  ScheduleFormCubit(this._scheduleRepository)
      : super(ScheduleFormState.initial());

  void resetForm() {
    emit(ScheduleFormState.initial());
  }

  void appointmentNameChanged(String eventName) {
    Appointment _appointment =
        state.appointment.setAttribut(eventName: eventName);
    emit(state.copyWith(appointment: _appointment));
  }

  void categoryChanged(String category) {
    Appointment _appointment =
        state.appointment.setAttribut(category: category);
    emit(state.copyWith(appointment: _appointment));
  }

  void allDayChanged(bool allDay) {
    Appointment _appointment = state.appointment.setAttribut(isAllDay: allDay);
    emit(state.copyWith(appointment: _appointment));
  }

  void startTimeChanged(DateTime newDateTime) {
    Appointment _appointment = state.appointment.setAttribut(from: newDateTime);
    emit(state.copyWith(appointment: _appointment));
  }

  void endTimeChanged(DateTime newDateTime) {
    Appointment _appointment = state.appointment.setAttribut(to: newDateTime);
    emit(state.copyWith(appointment: _appointment));
  }

  void saveAppointment(String userId) {
    _scheduleRepository.saveAppointment(userId, state.appointment);
    resetForm();
  }
}
