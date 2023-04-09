part of 'doctors_token_count_bloc.dart';

@immutable
abstract class DoctorsTokenCountState {}

class DoctorsTokenCountInitialState extends DoctorsTokenCountState {}

class DoctorsTokenCountLoadingState extends DoctorsTokenCountState {}

class DoctorsTokenCountSuccessState extends DoctorsTokenCountState {
  final List<Map<String, dynamic>> tokenCounts;

  DoctorsTokenCountSuccessState({required this.tokenCounts});
}

class DoctorsTokenCountFailureState extends DoctorsTokenCountState {
  final String message;

  DoctorsTokenCountFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
