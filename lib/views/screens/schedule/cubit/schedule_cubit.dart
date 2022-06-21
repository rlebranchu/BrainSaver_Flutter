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
    // At screen opening, we fetch automatically all appointments of user logged
    fetchListAppointmentOfUser(userId);
  }

  // Fetch all appointments of user logged
  void fetchListAppointmentOfUser(String userId) async {
    AppointmentDataSource appointments =
        await _scheduleRepository.fetchListAppointmentOfUser(userId);
    emit(state.copyWith(appointments: appointments));
  }

  // ASk to service to delete specific appointment
  void deleteAppointment(String userId, Appointment appointment) async {
    await _scheduleRepository.deleteAppointment(appointment);
    fetchListAppointmentOfUser(userId);
  }
}
