import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'token_event.dart';
part 'token_state.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  TokenBloc() : super(TokenInitialState()) {
    on<TokenEvent>((event, emit) async {
      emit(TokenLoadingState());

      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('tokens');
      try {
        if (event is CreateTokenEvent) {
          //create
          await queryTable.insert({
            'user_id': event.userId,
            'patient_id': event.patientId,
            'doctor_id': event.doctorId,
            'date_time': DateTime(
              event.date.year,
              event.date.month,
              event.date.day,
              event.time.hour,
              event.time.minute,
            ),
          });

          add(GetAllTokenEvent());
        } else if (event is CurrentTokenEvent) {}
      } catch (e, s) {
        log('$e\n$s');
        emit(TokenFailureState());
      }
    });
  }
}
