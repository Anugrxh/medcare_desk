import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'department_event.dart';
part 'department_state.dart';

class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  DepartmentBloc() : super(DepartmentInitialState()) {
    on<DepartmentEvent>((event, emit) async {
      emit(DepartmentLoadingState());
      try {
        SupabaseClient supabaseClient = Supabase.instance.client;
        SupabaseQueryBuilder queryTable = supabaseClient.from('departments');

        if (event is GetAllDepartmentsEvent) {
          List<dynamic> temp = [];

          if (event.query != null) {
            temp = await queryTable
                .select('*')
                .ilike('name', '%${event.query!}%')
                .order('name', ascending: true);
          } else {
            temp = await queryTable.select('*').order('name', ascending: true);
          }

          List<Map<String, dynamic>> departments =
              temp.map((e) => e as Map<String, dynamic>).toList();

          emit(DepartmentSuccessState(departments: departments));
        } else if (event is AddDepartmentsEvent) {
          await queryTable.insert({
            'name': event.department,
          });
          add(GetAllDepartmentsEvent());
        } else if (event is EditDepartmentsEvent) {
          await queryTable.update({
            'name': event.department,
          }).eq('id', event.id);
          add(GetAllDepartmentsEvent());
        } else if (event is DeleteDepartmentsEvent) {
          await queryTable.delete().eq('id', event.id);
          add(GetAllDepartmentsEvent());
        }
      } catch (e, s) {
        log("$e\n$s");
        emit(DepartmentFailureState(
          message: e.toString(),
        ));
      }
    });
  }
}
