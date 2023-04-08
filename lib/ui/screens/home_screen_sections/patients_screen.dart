import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/patients/manage_patients/manage_patients_bloc.dart';
import '../../widgets/custom_action_button.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_search.dart';
import '../../widgets/patient/add_patient_dialog.dart';
import '../../widgets/patient/patient_card.dart';

class PatientsScreen extends StatefulWidget {
  final bool selectMode;
  final Function(Map<String, dynamic>)? onSelect;
  const PatientsScreen({super.key, this.selectMode = false, this.onSelect});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  ManagePatientsBloc managePatientsBloc = ManagePatientsBloc();

  @override
  void initState() {
    super.initState();
    managePatientsBloc.add(GetAllPatientsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ManagePatientsBloc>.value(
      value: managePatientsBloc,
      child: BlocConsumer<ManagePatientsBloc, ManagePatientsState>(
        listener: (context, state) {
          if (state is ManagePatientsFailureState) {
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
          return Center(
            child: SizedBox(
              width: 1000,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomSearch(
                            onSearch: (value) {
                              managePatientsBloc.add(
                                GetAllPatientsEvent(
                                  query: value,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        CustomButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) =>
                                  BlocProvider<ManagePatientsBloc>.value(
                                value: managePatientsBloc,
                                child: const AddEditPatientDialog(),
                              ),
                            );
                          },
                          label: 'Add Patient',
                          icon: Icons.add,
                          iconColor: Colors.white,
                          labelColor: Colors.white,
                          buttonColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  state is ManagePatientsLoadingState
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
                    child: state is ManagePatientsSuccessState
                        ? state.patients.isNotEmpty
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
                                    state.patients.length,
                                    (index) => PatientCard(
                                      managePatientBloc: managePatientsBloc,
                                      patientDetails: state.patients[index],
                                      selectMode: widget.selectMode,
                                      onSelectPressed: () {
                                        widget.onSelect
                                            ?.call(state.patients[index]);
                                      },
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text('No Patients Found!'))
                        : state is ManagePatientsFailureState
                            ? Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomActionButton(
                                      iconData: Icons.replay_outlined,
                                      onPressed: () {
                                        managePatientsBloc
                                            .add(GetAllPatientsEvent());
                                      },
                                      label: 'Retry',
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
