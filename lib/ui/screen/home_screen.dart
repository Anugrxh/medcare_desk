import 'package:flutter/material.dart';
import 'package:medcare_desk/ui/screen/home_screen_sections/patient_section.dart';
import 'package:medcare_desk/ui/screen/login_screen.dart';

import '../widgets/appointment/doctor_card.dart';
import '../widgets/custom_button.dart';
import '../widgets/drawer_button.dart';
import 'home_screen_sections/appointment_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String? selectedValue;
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          tabController.index == 0 ? 'Tokens' : 'Patients',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          AppointmentSection(),
          PatientSection(),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: DrawerButton(
                label: "Appointments",
                isSelected: tabController.index == 0,
                onPressed: () {
                  tabController.animateTo(0);

                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: DrawerButton(
                label: "Patients",
                isSelected: tabController.index == 1,
                onPressed: () {
                  tabController.animateTo(1);

                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: DrawerButton(
                label: "Logout",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: SizedBox(
                          width: 300,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Do you really want to logout?",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomButton(
                                    label: "YES",
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    },
                                    buttonColor: Colors.blue,
                                    elevation: 2,
                                  ),
                                  CustomButton(
                                    label: "NO",
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    buttonColor: Colors.blue,
                                    elevation: 2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
