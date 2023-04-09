import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'patient_appointments_event.dart';
part 'patient_appointments_state.dart';

class PatientAppointmentsBloc
    extends Bloc<PatientAppointmentsEvent, PatientAppointmentsState> {
  PatientAppointmentsBloc() : super(PatientAppointmentsInitialState()) {
    on<PatientAppointmentsEvent>((event, emit) async {
      emit(PatientAppointmentsLoadingState());

      try {
        List<dynamic> temp = await Supabase.instance.client.rpc(
          'get_patient_appointments',
          params: {
            'search_patient_id': event.patientId,
          },
        );

        List<Map<String, dynamic>> appointments =
            temp.map((e) => e as Map<String, dynamic>).toList();

        emit(PatientAppointmentsSuccessState(appointments: appointments));
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(PatientAppointmentsFailureState());
      }
    });
  }
}
