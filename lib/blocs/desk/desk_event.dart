part of 'desk_bloc.dart';

@immutable
abstract class DeskEvent {}

class AddDeskEvent extends DeskEvent {
  final String name, phone, email, password;

  AddDeskEvent({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });
}

class EditDeskEvent extends DeskEvent {
  final String name, phone, email, userId;
  final String? password;

  EditDeskEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.userId,
    this.password,
  });
}

class DeleteDeskEvent extends DeskEvent {
  final String userId;

  DeleteDeskEvent({required this.userId});
}

class ChangeStatusDeskEvent extends DeskEvent {
  final String userId, status;

  ChangeStatusDeskEvent({
    required this.userId,
    required this.status,
  });
}

class GetAllDeskEvent extends DeskEvent {
  final String? query;

  GetAllDeskEvent({this.query});
}
