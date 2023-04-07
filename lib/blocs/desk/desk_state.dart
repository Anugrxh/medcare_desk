part of 'desk_bloc.dart';

@immutable
abstract class DeskState {}

class DeskInitialState extends DeskState {}

class DeskLoadingState extends DeskState {}

class DeskSuccessState extends DeskState {
  final List<Map<String, dynamic>> desks;

  DeskSuccessState({required this.desks});
}

class DeskFailureState extends DeskState {
  final String message;

  DeskFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
