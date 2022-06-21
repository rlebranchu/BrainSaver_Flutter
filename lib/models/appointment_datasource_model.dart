import 'package:brain_saver_flutter/models/appointment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' as sfCal;

class AppointmentDataSource extends sfCal.CalendarDataSource {
  // Creates a appointment data source : necessary to sfCalendar
  // collection to the calendar
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }

  //------------------------------------------------------------------
  // Getters to access to attributs of item of appointment's list
  //------------------------------------------------------------------
  @override
  DateTime getStartTime(int index) {
    return _getAppointmentData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getAppointmentData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getAppointmentData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getAppointmentData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getAppointmentData(index).isAllDay;
  }

  Appointment _getAppointmentData(int index) {
    final dynamic meeting = appointments![index];
    late final Appointment meetingData;
    if (meeting is Appointment) {
      meetingData = meeting;
    }
    return meetingData;
  }
}
