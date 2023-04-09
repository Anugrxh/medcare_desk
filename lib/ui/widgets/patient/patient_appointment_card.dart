import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medcare_desk/ui/widgets/custom_alert_dialog.dart';

import '../custom_action_button.dart';
import '../custom_card.dart';

class PatientAppointmentCard extends StatelessWidget {
  final Map<String, dynamic> patientAppointmentDetails;
  const PatientAppointmentCard({
    super.key,
    required this.patientAppointmentDetails,
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
              Text(
                '#${patientAppointmentDetails['id']}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                patientAppointmentDetails['doctor']['name'],
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Divider(
                height: 15,
                color: Color.fromARGB(66, 176, 176, 176),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          DateFormat('dd/MM/yyyy').format(DateTime.parse(
                              patientAppointmentDetails[
                                  'token_booking_date_time'])),
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Time',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          DateFormat('hh:mm a').format(DateTime.parse(
                              patientAppointmentDetails[
                                  'token_booking_date_time'])),
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 15,
                color: Color.fromARGB(66, 176, 176, 176),
              ),
              Text(
                'Department',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                patientAppointmentDetails['doctor']['department_name'],
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Divider(
                height: 15,
                color: Color.fromARGB(66, 176, 176, 176),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Token',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          patientAppointmentDetails['token_number'].toString(),
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Fee',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          patientAppointmentDetails['doctor']['fee'].toString(),
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 15,
                color: Color.fromARGB(66, 176, 176, 176),
              ),
              CustomActionButton(
                iconData: Icons.medical_information_outlined,
                label: 'Condition',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                      width: 700,
                      title: 'Condition',
                      message:
                          patientAppointmentDetails['token_condition'] != ''
                              ? patientAppointmentDetails['token_condition']
                              : 'Not Specified',
                    ),
                  );
                },
              ),
              const Divider(
                height: 15,
                color: Color.fromARGB(66, 176, 176, 176),
              ),
              CustomActionButton(
                iconData: Icons.document_scanner_outlined,
                label: 'Prescription',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                      width: 700,
                      title: 'Prescription',
                      message:
                          patientAppointmentDetails['token_prescription'] != ''
                              ? patientAppointmentDetails['token_prescription']
                              : 'Not Specified',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
