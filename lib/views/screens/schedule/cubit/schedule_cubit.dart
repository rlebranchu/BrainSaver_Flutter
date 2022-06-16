import 'package:bloc/bloc.dart';
import 'package:brain_saver_flutter/models/appointment_datasource_model.dart';
import 'package:brain_saver_flutter/models/appointment_model.dart';
import 'package:brain_saver_flutter/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final ScheduleRepository _scheduleRepository;

  ScheduleCubit(this._scheduleRepository, String userId)
      : super(ScheduleState.initial()) {
    fetchListAppointmentOfUser(userId);
  }

  void fetchListAppointmentOfUser(String userId) async {
    AppointmentDataSource appointments =
        await _scheduleRepository.fetchListAppointmentOfUser(userId);
    emit(state.copyWith(appointments: appointments));
  }

  void deleteAppointment(String userId, Appointment appointment) async {
    await _scheduleRepository.deleteAppointment(appointment);
    fetchListAppointmentOfUser(userId);
  }
}
