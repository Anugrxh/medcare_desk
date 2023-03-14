part of 'doctors_bloc.dart';

@immutable
abstract class DoctorsEvent {}

class GetAllDoctorsEvent extends DoctorsEvent {
  final int? departmentId;

  GetAllDoctorsEvent({this.departmentId});
}
