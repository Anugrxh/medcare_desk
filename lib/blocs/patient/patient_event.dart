part of 'patient_bloc.dart';

@immutable
abstract class PatientEvent {}

class CreatePatientEvent extends PatientEvent {
  final String name, userId, sex;
  final DateTime dob;

  CreatePatientEvent({
    required this.name,
    required this.userId,
    required this.sex,
    required this.dob,
  });
}

class EditPatientEvent extends PatientEvent {
  final int patientId;
  final String name, userId, sex;
  final DateTime dob;

  EditPatientEvent({
    required this.patientId,
    required this.name,
    required this.userId,
    required this.sex,
    required this.dob,
  });
}

class RemovePatientEvent extends PatientEvent {
  final int patientId;

  RemovePatientEvent({required this.patientId});
}

class GetAllPatientEvent extends PatientEvent {}
