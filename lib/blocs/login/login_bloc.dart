import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        await Supabase.instance.client.auth.signInWithPassword(
          email: event.email,
          password: event.password,
        );

        emit(LoginSuccessState());
      } catch (e, s) {
        log("$e\n$s");
        emit(LoginFailureState());
      }
    });
  }
}
