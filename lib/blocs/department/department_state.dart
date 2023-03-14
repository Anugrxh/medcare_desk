part of 'department_bloc.dart';

@immutable
abstract class DepartmentState {}

class DepartmentInitialState extends DepartmentState {}

class DepartmentLoadingState extends DepartmentState {}

class DepartmentSuccessState extends DepartmentState {}

class DepartmentFailureState extends DepartmentState {}
