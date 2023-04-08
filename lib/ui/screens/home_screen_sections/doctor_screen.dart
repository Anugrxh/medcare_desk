import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/doctor/doctor_bloc.dart';
import '../../widgets/custom_action_button.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_search.dart';
import '../../widgets/department_selector.dart';
import '../../widgets/doctor/add_edit_doctor_dialog.dart';
import '../../widgets/doctor/doctor_card.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  String? _query;
  int? _departmentId;

  final DoctorBloc doctorBloc = DoctorBloc();

  @override
  void initState() {
    doctorBloc.add(GetAllDoctorEvent());
    super.initState();
  }

  void search() {
    doctorBloc.add(
      GetAllDoctorEvent(
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
          child: BlocProvider<DoctorBloc>.value(
            value: doctorBloc,
            child: BlocConsumer<DoctorBloc, DoctorState>(
              listener: (context, state) {
                if (state is DoctorFailureState) {
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
                    state is DoctorLoadingState
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
                      child: state is DoctorSuccessState
                          ? state.doctors.isNotEmpty
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
                                      state.doctors.length,
                                      (index) => DoctorCard(
                                        doctorBloc: doctorBloc,
                                        doctorDetails: state.doctors[index],
                                      ),
                                    ),
                                  ),
                                )
                              : const Center(child: Text('No Doctors Found!'))
                          : state is DoctorFailureState
                              ? Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomActionButton(
                                        iconData: Icons.replay_outlined,
                                        onPressed: () {
                                          doctorBloc.add(GetAllDoctorEvent());
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
