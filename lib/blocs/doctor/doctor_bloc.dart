import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../util/format_time_of_day.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../util/iterable_extension.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  DoctorBloc() : super(DoctorInitialState()) {
    on<DoctorEvent>((event, emit) async {
      emit(DoctorLoadingState());

      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('doctors');

      try {
        if (event is GetAllDoctorEvent) {
          List<dynamic> temp = await supabaseClient.rpc(
            'get_doctors',
            params: {
              'query': event.query ?? '',
              'passed_department_id': event.departmentId ?? 0,
            },
          );

          List<User> users =
              await supabaseClient.auth.admin.listUsers(perPage: 1000);

          List<Map<String, dynamic>> doctors = temp.map((e) {
            Map<String, dynamic> element = e as Map<String, dynamic>;

            User? user =
                users.firstOrNull((user) => user.id == element['user_id']);

            element['status'] =
                user != null ? user.userMetadata!['status'] : '';
            element['email'] = user != null ? user.email : '';

            return element;
          }).toList();

          emit(DoctorSuccessState(doctors: doctors));
        } else if (event is AddDoctorEvent) {
          UserResponse userDetails = await supabaseClient.auth.admin.createUser(
            AdminUserAttributes(
              email: event.email,
              password: event.password,
              userMetadata: {
                'status': 'active',
              },
            ),
          );
          if (userDetails.user != null) {
            await queryTable.insert({
              'user_id': userDetails.user!.id,
              'name': event.name,
              'phone_number': event.phone,
              'dob': event.dob.toIso8601String(),
              'sex': event.sex,
              'fee': event.fee,
              'department_id': event.departmentId,
              'time_from': formatTimeOfDay(event.timeFrom),
              'time_to': formatTimeOfDay(event.timeTo),
              'off_day': event.offDay,
            });
            add(GetAllDoctorEvent());
          } else {
            emit(DoctorFailureState());
          }
        } else if (event is EditDoctorEvent) {
          AdminUserAttributes attributes =
              AdminUserAttributes(email: event.email);

          if (event.password != null) {
            attributes.password = event.password;
          }

          UserResponse userDetails =
              await supabaseClient.auth.admin.updateUserById(
            event.userId,
            attributes: attributes,
          );
          if (userDetails.user != null) {
            await queryTable.update({
              'name': event.name,
              'phone_number': event.phone,
              'dob': event.dob.toIso8601String(),
              'sex': event.sex,
              'fee': event.fee,
              'department_id': event.departmentId,
              'time_from': formatTimeOfDay(event.timeFrom),
              'time_to': formatTimeOfDay(event.timeTo),
              'off_day': event.offDay,
            }).eq('user_id', event.userId);
            add(GetAllDoctorEvent());
          } else {
            emit(DoctorFailureState());
          }
        } else if (event is DeleteDoctorEvent) {
          await queryTable.delete().eq('user_id', event.userId);
          await supabaseClient.auth.admin.deleteUser(event.userId);
          add(GetAllDoctorEvent());
        } else if (event is ChangeStatusDoctorEvent) {
          await supabaseClient.auth.admin.updateUserById(
            event.userId,
            attributes: AdminUserAttributes(
              userMetadata: {
                'status': event.status,
              },
              banDuration: event.status == 'active' ? 'none' : '1000h0m',
            ),
          );
          add(GetAllDoctorEvent());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(DoctorFailureState(message: e.toString()));
      }
    });
  }
}
