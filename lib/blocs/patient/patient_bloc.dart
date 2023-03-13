import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  PatientBloc() : super(PatientInitialState()) {
    on<PatientEvent>((event, emit) async {
      emit(PatientLoadingState());

      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('patients');

      try {
        if (event is CreatePatientEvent) {
          //create
          await queryTable.insert({
            'user_id': event.userId,
            'name': event.name,
            'dob': event.dob,
            'sex': event.sex,
          });

          add(GetAllPatientEvent());
        } else if (event is EditPatientEvent) {
          //edit
          await queryTable.update({
            'user_id': event.userId,
            'name': event.name,
            'dob': event.dob,
            'sex': event.sex,
          }).eq('id', event.patientId);

          add(GetAllPatientEvent());
        } else if (event is RemovePatientEvent) {
          //remove
          await queryTable.delete().eq('id', event.patientId);

          add(GetAllPatientEvent());
        } else if (event is GetAllPatientEvent) {
          //get

          List<Map<String, dynamic>> patients =
              await queryTable.select('*').order('name', ascending: true);

          emit(PatientSuccessState(patients));
        }
      } catch (e, s) {
        log('$e\n$s');
        emit(PatientFailureState());
      }
    });
  }
}
