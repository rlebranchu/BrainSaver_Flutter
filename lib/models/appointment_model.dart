import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  final String id;
  final DateTime? date;

  const Appointment({required this.id, this.date});

  static const empty = Appointment(id: '');

  bool get isEmpty => this == Appointment.empty;
  bool get isNotEmpty => this != Appointment.empty;

  @override
  List<Object?> get props => [id, date];

  Appointment.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        date = doc.data()!["date"];
}
