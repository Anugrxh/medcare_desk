import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcare_desk/ui/widgets/appointment/new_appointment_dialog.dart';

import '../../../blocs/doctor_appointments/doctor_appointments_bloc.dart';
import '../../widgets/custom_action_button.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_search.dart';
import '../../widgets/department_selector.dart';
import '../../widgets/appointment/appointment_card.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  String? _query;
  int? _departmentId;

  final DoctorAppointmentsBloc appointmentBloc = DoctorAppointmentsBloc();

  @override
  void initState() {
    appointmentBloc.add(GetAllDoctorAppointmentsEvent());
    super.initState();
  }

  void search() {
    appointmentBloc.add(
      GetAllDoctorAppointmentsEvent(
        query: _query,
        departmentId: _departmentId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 1000,
          child: BlocProvider<DoctorAppointmentsBloc>.value(
            value: appointmentBloc,
            child:
                BlocConsumer<DoctorAppointmentsBloc, DoctorAppointmentsState>(
              listener: (context, state) {
                if (state is DoctorAppointmentsFailureState) {
                  showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                      title: 'Failure',
                      message: state.message,
                      primaryButtonLabel: 'Ok',
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomSearch(
                              onSearch: (value) {
                                _query = value;
                                search();
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          DepartmentSelector(
                            onSelect: (id) {
                              _departmentId = id == 0 ? null : id;
                              search();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    state is DoctorAppointmentsLoadingState
                        ? const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              height: 1,
                              child: LinearProgressIndicator(),
                            ),
                          )
                        : const Divider(
                            height: 1,
                            endIndent: 20,
                            indent: 20,
                          ),
                    Expanded(
                      child: state is DoctorAppointmentsSuccessState
                          ? state.appointments.isNotEmpty
                              ? SingleChildScrollView(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 10,
                                  ),
                                  child: Wrap(
                                    spacing: 20,
                                    runSpacing: 20,
                                    alignment: WrapAlignment.start,
                                    children: List<Widget>.generate(
                                      state.appointments.length,
                                      (index) => AppointmentCard(
                                        appointmentsBloc: appointmentBloc,
                                        appointmentDetails:
                                            state.appointments[index],
                                      ),
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: Text('No Appointments Found!'))
                          : state is DoctorAppointmentsFailureState
                              ? Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomActionButton(
                                        iconData: Icons.replay_outlined,
                                        onPressed: () {
                                          appointmentBloc.add(
                                              GetAllDoctorAppointmentsEvent());
                                        },
                                        label: 'Retry',
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
