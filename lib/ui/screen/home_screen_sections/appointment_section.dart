import 'package:flutter/material.dart';

import '../../widgets/appointment/doctor_card.dart';

class AppointmentSection extends StatefulWidget {
  const AppointmentSection({
    Key? key,
  }) : super(key: key);

  @override
  State<AppointmentSection> createState() => _AppointmentSectionState();
}

class _AppointmentSectionState extends State<AppointmentSection> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: DropdownButton(
                borderRadius: BorderRadius.circular(10),
                underline: const SizedBox(),
                hint: const Text(
                  'Department',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: '1',
                    child: Text('Cardiology'),
                  ),
                  DropdownMenuItem(
                    value: '2',
                    child: Text('Urology'),
                  ),
                  DropdownMenuItem(
                    value: '3',
                    child: Text('Neurology'),
                  ),
                  DropdownMenuItem(
                    value: '4',
                    child: Text('ENT'),
                  ),
                  DropdownMenuItem(
                    value: '5',
                    child: Text('Gynaecology'),
                  ),
                  DropdownMenuItem(
                    value: '6',
                    child: Text('Psychiatry'),
                  ),
                  DropdownMenuItem(
                    value: '7',
                    child: Text('Dental'),
                  ),
                  DropdownMenuItem(
                    value: '8',
                    child: Text('Paediatric'),
                  )
                ],
                value: selectedValue,
                onChanged: (value) {
                  selectedValue = value;

                  setState(() {});
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Divider(
          height: 1,
          thickness: 1,
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SingleChildScrollView(
                child: Wrap(
                  children: List.generate(
                    20,
                    (index) => const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: DoctorCard(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
