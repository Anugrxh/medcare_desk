part of 'doctors_token_count_bloc.dart';

class DoctorsTokenCountEvent {
  final String? query;
  final int? departmentId;

  DoctorsTokenCountEvent({
    this.query,
    this.departmentId,
  });
}
