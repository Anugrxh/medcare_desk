import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../util/iterable_extension.dart';

part 'desk_event.dart';
part 'desk_state.dart';

class DeskBloc extends Bloc<DeskEvent, DeskState> {
  DeskBloc() : super(DeskInitialState()) {
    on<DeskEvent>((event, emit) async {
      emit(DeskLoadingState());

      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('desk_user');

      try {
        if (event is GetAllDeskEvent) {
          List<dynamic> temp = await supabaseClient.rpc(
            'get_desk_users',
            params: {
              'query': event.query ?? '',
            },
          );

          List<User> users =
              await supabaseClient.auth.admin.listUsers(perPage: 1000);

          List<Map<String, dynamic>> desks = temp.map((e) {
            Map<String, dynamic> element = e as Map<String, dynamic>;

            User? user =
                users.firstOrNull((user) => user.id == element['user_id']);

            element['status'] =
                user != null ? user.userMetadata!['status'] : '';
            element['email'] = user != null ? user.email : '';

            return element;
          }).toList();

          emit(DeskSuccessState(desks: desks));
        } else if (event is AddDeskEvent) {
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
            });
            add(GetAllDeskEvent());
          } else {
            emit(DeskFailureState());
          }
        } else if (event is EditDeskEvent) {
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
            }).eq('user_id', event.userId);
            add(GetAllDeskEvent());
          } else {
            emit(DeskFailureState());
          }
        } else if (event is DeleteDeskEvent) {
          await queryTable.delete().eq('user_id', event.userId);
          await supabaseClient.auth.admin.deleteUser(event.userId);
          add(GetAllDeskEvent());
        } else if (event is ChangeStatusDeskEvent) {
          await supabaseClient.auth.admin.updateUserById(
            event.userId,
            attributes: AdminUserAttributes(
              userMetadata: {
                'status': event.status,
              },
              banDuration: event.status == 'active' ? 'none' : '1000h0m',
            ),
          );
          add(GetAllDeskEvent());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(DeskFailureState(message: e.toString()));
      }
    });
  }
}
