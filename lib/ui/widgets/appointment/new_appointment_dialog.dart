import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medcare_desk/blocs/doctor_appointments/doctor_appointments_bloc.dart';
import 'package:medcare_desk/util/postgres_time_to_time_of_day.dart';

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
                builder: (context) => CustomScheduler(
                  offDay: widget.appointment['doctor_off_day'],
                  booked: widget.appointment['booked_date_times'],
                  timeFrom: convertPostgresTimeToTimeOfDay(
                      widget.appointment['doctor_time_from']),
                  timeTo: convertPostgresTimeToTimeOfDay(
                      widget.appointment['doctor_time_to']),
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
      primaryOnPressed: () {
        if (selectedDateTime != null && selectedPatient != null) {
          BlocProvider.of<DoctorAppointmentsBloc>(context).add(
            AddDoctorAppointmentEvent(
              number: (widget.appointment['issued_tokens'] + 1),
              patientId: selectedPatient!['id'],
              doctorId: widget.appointment['doctor_user_id'],
              bookedDateTime: selectedDateTime!,
            ),
          );
          Navigator.pop(context);
        } else {
          showDialog(
            context: context,
            builder: (context) => const CustomAlertDialog(
              title: 'Required!',
              message: 'Select booking date time and patient to continue',
              primaryButtonLabel: 'Ok',
            ),
          );
        }
      },
    );
  }
}
