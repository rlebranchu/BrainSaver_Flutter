import 'package:brain_saver_flutter/models/appointment_datasource_model.dart';
import 'package:brain_saver_flutter/models/appointment_model.dart';
import 'package:brain_saver_flutter/services/services.dart';

class ScheduleRepository {
  final ScheduleService _scheduleService = ScheduleService();

  // Ask to service to get the list of appointment of the user
  Future<AppointmentDataSource> fetchListAppointmentOfUser(
      String userId) async {
    return AppointmentDataSource(
        await _scheduleService.fetchListAppointmentOfUser(userId));
  }

  // Ask to service to save a new appointment
  Future<void> saveAppointment(String userId, Appointment appointment) async {
    await _scheduleService.saveAppointment(userId, appointment);
  }

  // Ask to service to delete existing appointment
  Future<void> deleteAppointment(Appointment appointment) async {
    await _scheduleService.deleteAppointment(appointment);
  }
}
