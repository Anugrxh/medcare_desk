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

      try {
        if (event is GetAllDoctorEvent) {
          List<dynamic> temp = await supabaseClient.rpc(
            'get_doctors',
            params: {
              'query': event.query ?? '',
              'passed_department_id': event.departmentId ?? 0,
            },
          );

          List<Map<String, dynamic>> doctors = temp.map((e) {
            Map<String, dynamic> element = e as Map<String, dynamic>;

            return element;
          }).toList();

          emit(DoctorSuccessState(doctors: doctors));
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(DoctorFailureState(message: e.toString()));
      }
    });
  }
}
