import 'package:flutter/material.dart';

import '../widgets/appointment/doctor_card.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              'Tokens',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
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
                      child: Text('One'),
                    ),
                    DropdownMenuItem(
                      value: '2',
                      child: Text('Two'),
                    ),
                    DropdownMenuItem(
                      value: '3',
                      child: Text('Three'),
                    ),
                    DropdownMenuItem(
                      value: '4',
                      child: Text('Four'),
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
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Material(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue,
                child: const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Center(
                    child: Text(
                      'Appoinments',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'Patient Registration',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'Doctors',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
