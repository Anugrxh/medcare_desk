part of 'token_bloc.dart';

@immutable
abstract class TokenEvent {}

class CreateTokenEvent extends TokenEvent {
  final String userId, patientId, doctorId;
  final DateTime date;
  final TimeOfDay time;

  CreateTokenEvent(
      {required this.userId,
      required this.patientId,
      required this.doctorId,
      required this.date,
      required this.time});
}

class CurrentTokenEvent extends TokenEvent {}

class PendingTokenEvent extends TokenEvent {}

class GetAllTokenEvent extends TokenEvent {}
