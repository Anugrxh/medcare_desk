import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'doctor_appointments_event.dart';
part 'doctor_appointments_state.dart';

class DoctorAppointmentsBloc
    extends Bloc<DoctorAppointmentsEvent, DoctorAppointmentsState> {
  DoctorAppointmentsBloc() : super(DoctorAppointmentsInitialState()) {
    on<DoctorAppointmentsEvent>((event, emit) async {
      emit(DoctorAppointmentsLoadingState());

      try {
        SupabaseClient supabaseClient = Supabase.instance.client;
        SupabaseQueryBuilder queryTable = supabaseClient.from('tokens');

        if (event is GetAllDoctorAppointmentsEvent) {
          //get
          List<dynamic> temp = (await supabaseClient.rpc(
                'get_doctors_appointments',
                params: {
                  'search_query': event.query ?? '',
                  'search_date':
                      DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  'search_department_id': event.departmentId ?? 0,
                },
              )) ??
              [];

          List<Map<String, dynamic>> appointments = temp.map((e) {
            Map<String, dynamic> element = e as Map<String, dynamic>;

            return element;
          }).toList();

          Logger().w(appointments);

          emit(DoctorAppointmentsSuccessState(appointments: appointments));
        } else if (event is AddDoctorAppointmentEvent) {
          //add
          await queryTable.insert({
            'number': event.number,
            'patient_id': event.patientId,
            'doctor_id': event.doctorId,
            'booking_date_time': event.bookedDateTime.toIso8601String(),
          });

          add(GetAllDoctorAppointmentsEvent());
        } else if (event is DeleteDoctorAppointmentEvent) {
          //delete
          await queryTable.delete().eq('id', event.appointmentId);
          add(GetAllDoctorAppointmentsEvent());
        }
      } catch (e, s) {
        Logger().e("$e\n$s");
        emit(DoctorAppointmentsFailureState(
          message: e.toString(),
        ));
      }
    });
  }
}
