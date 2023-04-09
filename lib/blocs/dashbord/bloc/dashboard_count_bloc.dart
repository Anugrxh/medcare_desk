import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'dashboard_count_event.dart';
part 'dashboard_count_state.dart';

class DashboardCountBloc
    extends Bloc<DashboardCountEvent, DashboardCountState> {
  DashboardCountBloc() : super(DashboardCountInitialState()) {
    on<DashboardCountEvent>((event, emit) async {
      emit(DashboardCountLoadingState());

      try {
        dynamic temp = await Supabase.instance.client.rpc(
          'dashboard_count',
          params: {
            'search_date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
          },
        );

        Map<String, dynamic> dashbordCount = temp as Map<String, dynamic>;

        emit(DashboardCountSuccessState(dashbordCount: dashbordCount));
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(DashboardCountFailureState());
      }
    });
  }
}
