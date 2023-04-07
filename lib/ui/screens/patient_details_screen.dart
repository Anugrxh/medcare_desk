import 'package:flutter/material.dart';
import '../../util/get_age.dart';
import '../widgets/patient/patient_appointment_card.dart';
import '../widgets/token_card.dart';

class PatientDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> patientDetails;
  const PatientDetailsScreen({
    super.key,
    required this.patientDetails,
  });

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                '#${patientDetails['id']}',
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
                patientDetails['name'],
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${getAge(DateTime.parse(patientDetails['dob'].toString()))}  ${patientDetails['sex']}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                patientDetails['phone_number'],
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
              ),
              const Divider(
                height: 40,
                color: Color.fromARGB(66, 176, 176, 176),
              ),
              const Text(
                'Appointment History',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                  fontSize: 15,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  child: Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    children: const [
                      PatientAppointmentCard(),
                      PatientAppointmentCard(),
                      PatientAppointmentCard(),
                      PatientAppointmentCard(),
                      PatientAppointmentCard(),
                      PatientAppointmentCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
