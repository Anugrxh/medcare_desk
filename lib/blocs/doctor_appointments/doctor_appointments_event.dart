part of 'doctor_appointments_bloc.dart';

@immutable
abstract class DoctorAppointmentsEvent {}

class GetAllDoctorAppointmentsEvent extends DoctorAppointmentsEvent {
  final String? query;
  final int? departmentId;

  GetAllDoctorAppointmentsEvent({
    this.query,
    this.departmentId,
  });
}

class AddDoctorAppointmentEvent extends DoctorAppointmentsEvent {
  final int number, patientId;
  final String doctorId;
  final DateTime bookedDateTime;

  AddDoctorAppointmentEvent({
    required this.number,
    required this.patientId,
    required this.doctorId,
    required this.bookedDateTime,
  });
}

class DeleteDoctorAppointmentEvent extends DoctorAppointmentsEvent {
  final int appointmentId;

  DeleteDoctorAppointmentEvent({required this.appointmentId});
}
