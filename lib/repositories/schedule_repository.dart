import 'package:brain_saver_flutter/models/appointment_datasource_model.dart';
import 'package:brain_saver_flutter/models/appointment_model.dart';
import 'package:brain_saver_flutter/services/services.dart';

class ScheduleRepository {
  final ScheduleService _scheduleService = ScheduleService();

  Future<AppointmentDataSource> fetchListAppointmentOfUser(
      String userId) async {
    return AppointmentDataSource(
        await _scheduleService.fetchListAppointmentOfUser(userId));
  }

  Future<void> saveAppointment(String userId, Appointment appointment) async {
    await _scheduleService.saveAppointment(userId, appointment);
  }
}
