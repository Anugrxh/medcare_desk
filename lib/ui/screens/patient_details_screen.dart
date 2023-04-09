import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcare_desk/blocs/patient_appointments/patient_appointments_bloc.dart';
import '../../util/get_age.dart';
import '../widgets/custom_action_button.dart';
import '../widgets/custom_alert_dialog.dart';
import '../widgets/patient/patient_appointment_card.dart';
import '../widgets/token_card.dart';

class PatientDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> patientDetails;
  const PatientDetailsScreen({
    super.key,
    required this.patientDetails,
  });

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  final PatientAppointmentsBloc patientAppointmentsBloc =
      PatientAppointmentsBloc();

  @override
  void initState() {
    super.initState();
    patientAppointmentsBloc.add(
      PatientAppointmentsEvent(
        patientId: widget.patientDetails['id'],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: const BackButton(
          color: Colors.black54,
        ),
        title: Text(
          'Patient Details',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SizedBox(
          width: 1000,
          child: BlocProvider<PatientAppointmentsBloc>.value(
            value: patientAppointmentsBloc,
            child:
                BlocConsumer<PatientAppointmentsBloc, PatientAppointmentsState>(
              listener: (context, state) {
                if (state is PatientAppointmentsFailureState) {
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
                      height: 40,
                    ),
                    Text(
                      '#${widget.patientDetails['id']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.patientDetails['name'],
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${getAge(DateTime.parse(widget.patientDetails['dob'].toString()))}  ${widget.patientDetails['sex']}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.patientDetails['phone_number'],
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                    ),
                    const SizedBox(height: 20),
                    state is PatientAppointmentsLoadingState
                        ? const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              height: 1,
                              child: LinearProgressIndicator(),
                            ),
                          )
                        : const Divider(
                            height: 1,
                          ),
                    const SizedBox(height: 20),
                    const Text(
                      'Appointment History',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                        fontSize: 15,
                      ),
                    ),
                    Expanded(
                      child: state is PatientAppointmentsSuccessState
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
                                      (index) => PatientAppointmentCard(
                                        patientAppointmentDetails:
                                            state.appointments[index],
                                      ),
                                    ),
                                  ),
                                )
                              : const Center(child: Text('No Doctors Found!'))
                          : state is PatientAppointmentsFailureState
                              ? Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomActionButton(
                                        iconData: Icons.replay_outlined,
                                        onPressed: () {
                                          patientAppointmentsBloc.add(
                                            PatientAppointmentsEvent(
                                              patientId:
                                                  widget.patientDetails['id'],
                                            ),
                                          );
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
