import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/patients/manage_patients/manage_patients_bloc.dart';
import '../../../util/get_age.dart';
import '../../screens/patient_details_screen.dart';
import '../custom_action_button.dart';
import '../custom_alert_dialog.dart';
import '../custom_card.dart';
import 'add_patient_dialog.dart';

class PatientCard extends StatelessWidget {
  final Map<String, dynamic> patientDetails;
  final ManagePatientsBloc managePatientBloc;
  const PatientCard({
    super.key,
    required this.patientDetails,
    required this.managePatientBloc,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SizedBox(
        width: 310,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '#${patientDetails['id']}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${patientDetails['name']}',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => BlocProvider.value(
                          value: managePatientBloc,
                          child: AddEditPatientDialog(
                            patientData: patientDetails,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: Colors.orange,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => CustomAlertDialog(
                          title: 'Are you sure?',
                          message:
                              'Are you sure you want to delet this patient? any data associated with this patient will be deleted as well',
                          primaryButtonLabel: 'Delete',
                          primaryOnPressed: () {
                            managePatientBloc.add(
                              DeletePatientEvent(
                                patientId: patientDetails['id'],
                              ),
                            );
                            Navigator.pop(context);
                          },
                          secondaryButtonLabel: 'Cancel',
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 20,
                endIndent: 150,
              ),
              Text(
                '${getAge(DateTime.parse(patientDetails['dob'].toString()))}  ${patientDetails['sex']}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Divider(
                height: 20,
                color: Color.fromARGB(66, 176, 176, 176),
              ),
              Text(
                'Phone Number',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                patientDetails['phone_number'],
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Divider(
                height: 20,
                color: Color.fromARGB(66, 176, 176, 176),
              ),
              CustomActionButton(
                iconData: Icons.arrow_outward,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PatientDetailsScreen(
                        patientDetails: patientDetails,
                      ),
                    ),
                  );
                },
                label: 'Appointments',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
