part of 'patient_appointments_bloc.dart';

@immutable
abstract class PatientAppointmentsState {}

class PatientAppointmentsInitialState extends PatientAppointmentsState {}

class PatientAppointmentsLoadingState extends PatientAppointmentsState {}

class PatientAppointmentsSuccessState extends PatientAppointmentsState {
  final List<Map<String, dynamic>> appointments;

  PatientAppointmentsSuccessState({required this.appointments});
}

class PatientAppointmentsFailureState extends PatientAppointmentsState {
  final String message;

  PatientAppointmentsFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
