part of 'patient_bloc.dart';

@immutable
abstract class PatientState {}

class PatientInitialState extends PatientState {}

class PatientLoadingState extends PatientState {}

class PatientSuccessState extends PatientState {
  final List<Map<String, dynamic>> patients;

  PatientSuccessState(this.patients);
}

class PatientFailureState extends PatientState {}
