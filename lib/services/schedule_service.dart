import 'package:brain_saver_flutter/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // constant to get collections name
  static const String collectionName = "appointments";

  // get the list of appointment of the user
  Future<List<Appointment>> fetchListAppointmentOfUser(String userId) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection(collectionName)
        // check userId to get only the appointments of user logged
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs
        .map((docSnapshot) => Appointment.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  // Save the appointment with userId data
  Future<void> saveAppointment(String userId, Appointment appointment) async {
    await _firestore
        .collection(collectionName)
        .add(appointment.toDocument(userId));
  }

  // Delete specific appointment
  Future<void> deleteAppointment(Appointment appointment) async {
    await _firestore.collection(collectionName).doc(appointment.id).delete();
  }
}
