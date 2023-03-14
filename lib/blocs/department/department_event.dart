part of 'department_bloc.dart';

@immutable
abstract class DepartmentEvent {}

class GetAllDepatmentEvent extends DepartmentEvent {
  final int? departmentId;

  GetAllDepatmentEvent(this.departmentId);
}
