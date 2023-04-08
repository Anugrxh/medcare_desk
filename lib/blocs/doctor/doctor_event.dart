part of 'doctor_bloc.dart';

@immutable
abstract class DoctorEvent {}

class GetAllDoctorEvent extends DoctorEvent {
  final String? query;
  final int? departmentId;

  GetAllDoctorEvent({
    this.query,
    this.departmentId,
  });
}
