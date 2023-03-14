import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'department_event.dart';
part 'department_state.dart';

class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  DepartmentBloc() : super(DepartmentInitialState()) {
    on<DepartmentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
