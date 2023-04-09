import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'doctors_token_count_event.dart';
part 'doctors_token_count_state.dart';

class DoctorsTokenCountBloc
    extends Bloc<DoctorsTokenCountEvent, DoctorsTokenCountState> {
  DoctorsTokenCountBloc() : super(DoctorsTokenCountInitialState()) {
    on<DoctorsTokenCountEvent>((event, emit) async {
      emit(DoctorsTokenCountLoadingState());

      try {
        List<dynamic> temp = await Supabase.instance.client.rpc(
          'doctors_tokens_count',
          params: {
            'search_query': event.query ?? '',
            'search_date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
            'search_department_id': event.departmentId ?? 0,
          },
        );

        List<Map<String, dynamic>> tokenCounts =
            temp.map((e) => e as Map<String, dynamic>).toList();

        emit(DoctorsTokenCountSuccessState(tokenCounts: tokenCounts));
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(DoctorsTokenCountFailureState());
      }
    });
  }
}
