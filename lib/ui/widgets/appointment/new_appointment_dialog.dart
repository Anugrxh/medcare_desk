import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../screens/patient_selector_screen.dart';
import '../custom_alert_dialog.dart';
import '../custom_button.dart';
import '../custom_scheduler.dart';

class NewAppointmentDialog extends StatefulWidget {
  final Map<String, dynamic> appointment;
  const NewAppointmentDialog({
    super.key,
    required this.appointment,
  });

  @override
  State<NewAppointmentDialog> createState() => _NewAppointmentDialogState();
}

class _NewAppointmentDialogState extends State<NewAppointmentDialog> {
  Map<String, dynamic>? selectedPatient;
  DateTime? selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: 'New Appointment',
      message: 'Fill the following details to book an appointment',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Scheduled At',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 5),
          CustomButton(
            label: selectedDateTime != null
                ? DateFormat('EEE d MMM yyyy hh:mm a').format(selectedDateTime!)
                : 'Select Date & Time',
            onPressed: () async {
              selectedDateTime = await showDialog(
                context: context,
                builder: (context) => const CustomScheduler(
                  booked: [],
                  timeFrom: TimeOfDay(hour: 10, minute: 30),
                  timeTo: TimeOfDay(hour: 15, minute: 30),
                ),
              );
              setState(() {});
            },
          ),
          const Divider(height: 20),
          Text(
            'Select Patient',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 5),
          CustomButton(
            label: selectedPatient != null
                ? selectedPatient!['name']
                : 'Select Patient',
            onPressed: () async {
              selectedPatient = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PatientSelector(),
                ),
              );
              setState(() {});
            },
          ),
        ],
      ),
      primaryButtonLabel: 'Book',
      primaryOnPressed: () {},
    );
  }
}
