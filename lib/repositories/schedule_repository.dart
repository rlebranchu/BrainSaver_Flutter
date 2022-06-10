import 'package:brain_saver_flutter/models/models.dart';
import 'package:brain_saver_flutter/services/services.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final ScheduleService service = ScheduleService();

  @override
  Future<List<Appointment>> fetchListAppointmentOfUser(String userId) {
    return service.fetchListAppointmentOfUser(userId);
  }
}

abstract class DatabaseRepository {
  Future<List<Appointment>> fetchListAppointmentOfUser(String userId);
}
