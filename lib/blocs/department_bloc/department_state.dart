part of 'department_bloc.dart';

@immutable
abstract class DepartmentState {}

class DepartmentInitialState extends DepartmentState {}

class DepartmentLoadingState extends DepartmentState {}

class DepartmentSuccessState extends DepartmentState {
  final List<Map<String, dynamic>> departments;

  DepartmentSuccessState({required this.departments});
}

class DepartmentFailureState extends DepartmentState {
  final String message;

  DepartmentFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
