import 'package:brain_saver_flutter/models/category_appointment_model.dart';
import 'package:brain_saver_flutter/models/const_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Appointment extends Equatable {
  final String id;
  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final String category;
  final bool isAllDay;

  const Appointment(
      {required this.id,
      required this.eventName,
      required this.from,
      required this.to,
      required this.background,
      required this.category,
      required this.isAllDay});

  static final empty = Appointment(
    id: '',
    eventName: '',
    from: DateTime.now().add(const Duration(days: 1)).getDateOnly(),
    to: DateTime.now().add(const Duration(days: 1)).getDateOnly(),
    background: CATEGORYCOLOR.first.color,
    category: CATEGORYCOLOR.first.name,
    isAllDay: false,
  );

  @override
  List<Object?> get props =>
      [id, eventName, from, to, background, category, isAllDay];

  static Color _getBackgroundColorByCategory(String categoryName) =>
      (CATEGORYCOLOR.firstWhere(
          (category) => category.isCategoryNamed(categoryName),
          orElse: () => CategoryAppointment.error)).color;

  static bool _isAllDay(DateTime startTime, DateTime endTime) =>
      startTime.isAtSameMomentAs(endTime) &&
      startTime.hour == 0 &&
      startTime.minute == 0 &&
      startTime.second == 0;

  Appointment.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        eventName = doc.data()!["title"],
        from = doc.data()!["startTime"].toDate(),
        to = doc.data()!["endTime"].toDate(),
        background = _getBackgroundColorByCategory(doc.data()!["category"]),
        category = doc.data()!["category"],
        isAllDay = _isAllDay(
            doc.data()!["startTime"].toDate(), doc.data()!["endTime"].toDate());

  Map<String, dynamic> toDocument(String userId) {
    return {
      "category": category,
      "startTime": isAllDay ? DateTime.now().getDateOnly() : from,
      "endTime": isAllDay ? DateTime.now().getDateOnly() : to,
      "title": eventName,
      "userId": userId
    };
  }

  Appointment setAttribut({
    String? id,
    String? eventName,
    DateTime? from,
    DateTime? to,
    Color? background,
    String? category,
    bool? isAllDay,
  }) {
    return Appointment(
      id: id ?? this.id,
      eventName: eventName ?? this.eventName,
      from: from ?? this.from,
      to: to ?? this.to,
      background: background ?? this.background,
      category: category ?? this.category,
      isAllDay: isAllDay ?? this.isAllDay,
    );
  }
}

extension DateExtension on DateTime {
  DateTime getDateOnly() {
    return DateTime(this.year, this.month, this.day);
  }
}
