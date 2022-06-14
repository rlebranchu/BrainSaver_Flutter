import 'package:brain_saver_flutter/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Appointment>> fetchListAppointmentOfUser(String userId) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection("appointments")
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs
        .map((docSnapshot) => Appointment.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<void> saveAppointment(String userId, Appointment appointment) async {
    await _firestore
        .collection("appointments")
        .add(appointment.toDocument(userId));
  }
}
