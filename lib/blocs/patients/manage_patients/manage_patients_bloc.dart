import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'manage_patients_event.dart';
part 'manage_patients_state.dart';

class ManagePatientsBloc
    extends Bloc<ManagePatientsEvent, ManagePatientsState> {
  ManagePatientsBloc() : super(ManagePatientsInitialState()) {
    on<ManagePatientsEvent>((event, emit) async {
      emit(ManagePatientsLoadingState());

      SupabaseClient supabaseClient = Supabase.instance.client;

      try {
        if (event is GetAllPatientsEvent) {
          List<dynamic> temp = await supabaseClient.rpc(
            'get_patients',
            params: {
              'query': event.query ?? '',
            },
          );

          List<Map<String, dynamic>> patients =
              temp.map((e) => e as Map<String, dynamic>).toList();

          emit(ManagePatientsSuccessState(patients: patients));
        } else if (event is AddPatientEvent) {
          await supabaseClient.from('patients').insert({
            'name': event.name,
            'sex': event.sex,
            'phone_number': event.phoneNumber,
            'dob': event.dob.toIso8601String(),
          });
          add(GetAllPatientsEvent());
        } else if (event is EditPatientEvent) {
          await supabaseClient.from('patients').update({
            'name': event.name,
            'sex': event.sex,
            'phone_number': event.phoneNumber,
            'dob': event.dob.toIso8601String(),
          }).eq('id', event.patientId);
          add(GetAllPatientsEvent());
        } else if (event is DeletePatientEvent) {
          await supabaseClient
              .from('patients')
              .delete()
              .eq('id', event.patientId);
          add(GetAllPatientsEvent());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(ManagePatientsFailureState(message: e.toString()));
      }
    });
  }
}
