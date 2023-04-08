part of 'doctor_appointments_bloc.dart';

@immutable
abstract class DoctorAppointmentsState {}

class DoctorAppointmentsInitialState extends DoctorAppointmentsState {}

class DoctorAppointmentsLoadingState extends DoctorAppointmentsState {}

class DoctorAppointmentsSuccessState extends DoctorAppointmentsState {
  final List<Map<String, dynamic>> appointments;

  DoctorAppointmentsSuccessState({required this.appointments});
}

class DoctorAppointmentsFailureState extends DoctorAppointmentsState {
  final String message;

  DoctorAppointmentsFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
