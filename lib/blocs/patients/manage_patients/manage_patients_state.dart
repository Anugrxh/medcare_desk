part of 'manage_patients_bloc.dart';

@immutable
abstract class ManagePatientsState {}

class ManagePatientsInitialState extends ManagePatientsState {}

class ManagePatientsLoadingState extends ManagePatientsState {}

class ManagePatientsSuccessState extends ManagePatientsState {
  final List<Map<String, dynamic>> patients;

  ManagePatientsSuccessState({required this.patients});
}

class ManagePatientsFailureState extends ManagePatientsState {
  final String message;

  ManagePatientsFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
