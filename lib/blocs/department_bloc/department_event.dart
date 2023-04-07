part of 'department_bloc.dart';

@immutable
abstract class DepartmentEvent {}

class GetAllDepartmentsEvent extends DepartmentEvent {
  final String? query;

  GetAllDepartmentsEvent({this.query});
}

class AddDepartmentsEvent extends DepartmentEvent {
  final String department;

  AddDepartmentsEvent({
    required this.department,
  });
}

class EditDepartmentsEvent extends DepartmentEvent {
  final int id;
  final String department;

  EditDepartmentsEvent({
    required this.id,
    required this.department,
  });
}

class DeleteDepartmentsEvent extends DepartmentEvent {
  final int id;

  DeleteDepartmentsEvent({required this.id});
}
