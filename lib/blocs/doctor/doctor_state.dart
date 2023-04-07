part of 'doctor_bloc.dart';

@immutable
abstract class DoctorState {}

class DoctorInitialState extends DoctorState {}

class DoctorLoadingState extends DoctorState {}

class DoctorSuccessState extends DoctorState {
  final List<Map<String, dynamic>> doctors;

  DoctorSuccessState({required this.doctors});
}

class DoctorFailureState extends DoctorState {
  final String message;

  DoctorFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
