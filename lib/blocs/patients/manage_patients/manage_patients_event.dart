part of 'manage_patients_bloc.dart';

@immutable
abstract class ManagePatientsEvent {}

class GetAllPatientsEvent extends ManagePatientsEvent {
  final String? query;

  GetAllPatientsEvent({this.query});
}

class AddPatientEvent extends ManagePatientsEvent {
  final String name, sex, phoneNumber;
  final DateTime dob;

  AddPatientEvent({
    required this.name,
    required this.sex,
    required this.phoneNumber,
    required this.dob,
  });
}

class EditPatientEvent extends ManagePatientsEvent {
  final String name, sex, phoneNumber;
  final int patientId;
  final DateTime dob;

  EditPatientEvent({
    required this.patientId,
    required this.name,
    required this.sex,
    required this.phoneNumber,
    required this.dob,
  });
}

class DeletePatientEvent extends ManagePatientsEvent {
  final int patientId;

  DeletePatientEvent({
    required this.patientId,
  });
}
