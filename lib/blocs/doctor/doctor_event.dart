part of 'doctor_bloc.dart';

@immutable
abstract class DoctorEvent {}

class AddDoctorEvent extends DoctorEvent {
  final String name, email, phone, sex, password;
  final int departmentId, fee, offDay; //offday 1-7 1:monday, 7:sunday
  final DateTime dob;
  final TimeOfDay timeFrom, timeTo;

  AddDoctorEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.departmentId,
    required this.fee,
    required this.sex,
    required this.offDay,
    required this.dob,
    required this.timeFrom,
    required this.timeTo,
  });
}

class EditDoctorEvent extends DoctorEvent {
  final String name, email, phone, sex, userId;
  final String? password;
  final int departmentId, offDay, fee;
  final DateTime dob;
  final TimeOfDay timeFrom, timeTo;

  EditDoctorEvent({
    required this.name,
    required this.email,
    this.password,
    required this.phone,
    required this.offDay,
    required this.departmentId,
    required this.fee,
    required this.sex,
    required this.userId,
    required this.dob,
    required this.timeFrom,
    required this.timeTo,
  });
}

class DeleteDoctorEvent extends DoctorEvent {
  final String userId;

  DeleteDoctorEvent({required this.userId});
}

class ChangeStatusDoctorEvent extends DoctorEvent {
  final String userId, status;

  ChangeStatusDoctorEvent({
    required this.userId,
    required this.status,
  });
}

class GetAllDoctorEvent extends DoctorEvent {
  final String? query;
  final int? departmentId;

  GetAllDoctorEvent({
    this.query,
    this.departmentId,
  });
}
