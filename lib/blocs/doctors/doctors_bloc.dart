import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'doctors_event.dart';
part 'doctors_state.dart';

class DoctorsBloc extends Bloc<DoctorsEvent, DoctorsState> {
  DoctorsBloc() : super(DoctorsInitialState()) {
    on<DoctorsEvent>((event, emit) async {
      emit(DoctorsLoadingState());
      try {
        if (event is GetAllDoctorsEvent) {
          SupabaseQueryBuilder query = Supabase.instance.client.from('doctors');

          List<Map<String, dynamic>> doctors = [];

          if (event.departmentId != null) {
            doctors =
                await query.select('*').eq('department_id', event.departmentId);
          } else {
            doctors = await query.select('*');
          }

          emit(DoctorsSuccessState(doctors: doctors));
        }
      } catch (e, s) {
        //
      }
    });
  }
}
