part of 'doctors_bloc.dart';

@immutable
abstract class DoctorsState {}

class DoctorsInitialState extends DoctorsState {}

class DoctorsLoadingState extends DoctorsState {}

class DoctorsSuccessState extends DoctorsState {
  final List<Map<String, dynamic>> doctors;

  DoctorsSuccessState({required this.doctors});
}

class DoctorsFailureState extends DoctorsState {}
