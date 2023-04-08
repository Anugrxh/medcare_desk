import 'package:flutter/material.dart';
import 'package:medcare_desk/ui/screens/home_screen_sections/patients_screen.dart';

class PatientSelector extends StatelessWidget {
  const PatientSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black54,
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Select Patient',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        elevation: 1,
      ),
      body: PatientsScreen(
        selectMode: true,
        onSelect: (patient) {
          Navigator.pop(context, patient);
        },
      ),
    );
  }
}
