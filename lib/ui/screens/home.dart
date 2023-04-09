import 'package:flutter/material.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../widgets/custom_alert_dialog.dart';
import '../widgets/custom_card.dart';
import '../widgets/drawer_button.dart';
import 'home_screen_sections/appoinment_screen.dart';
import 'home_screen_sections/dashbord.dart';
import 'home_screen_sections/doctor_screen.dart';
import 'home_screen_sections/patients_screen.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    Future.delayed(
      const Duration(
        milliseconds: 100,
      ),
      () {
        if (Supabase.instance.client.auth.currentUser == null) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const Login(),
            ),
            (route) => true,
          );
        }
      },
    );

    _tabController = TabController(
      length: 4,
      initialIndex: 2,
      vsync: this,
    );
    super.initState();
  }

  String getTitle(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Doctors';
      case 2:
        return 'Appointments';
      case 3:
        return 'Patients';

      default:
        return 'Dashboard';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTitle(_tabController?.index ?? 0),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          DashboardScreen(),
          DoctorScreen(),
          AppointmentScreen(),
          PatientsScreen(),
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                'MENU',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerButton(
                iconData: Icons.dashboard_outlined,
                label: 'DASHBOARD',
                onPressed: () {
                  _tabController!.animateTo(0);
                  setState(() {});
                  Navigator.pop(context);
                },
                isSelected: _tabController!.index == 0,
              ),
              const SizedBox(
                height: 20,
              ),
              DrawerButton(
                iconData: Icons.person_outline,
                label: 'DOCTORS',
                onPressed: () {
                  _tabController!.animateTo(1);
                  setState(() {});
                  Navigator.pop(context);
                },
                isSelected: _tabController!.index == 1,
              ),
              const SizedBox(
                height: 20,
              ),
              DrawerButton(
                iconData: Icons.receipt_outlined,
                label: 'APPOINTMENTS',
                onPressed: () {
                  _tabController!.animateTo(2);
                  setState(() {});
                  Navigator.pop(context);
                },
                isSelected: _tabController!.index == 2,
              ),
              const SizedBox(
                height: 20,
              ),
              DrawerButton(
                iconData: Icons.person_3_outlined,
                label: 'PATIENTS',
                onPressed: () {
                  _tabController!.animateTo(3);
                  setState(() {});
                  Navigator.pop(context);
                },
                isSelected: _tabController!.index == 3,
              ),
              const SizedBox(
                height: 20,
              ),
              DrawerButton(
                iconData: Icons.lock_outline,
                label: 'CHANGE PASSWORD',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const ChangePasswordDialog(),
                  );
                },
                isSelected: false,
              ),
              const SizedBox(
                height: 20,
              ),
              DrawerButton(
                iconData: Icons.logout_outlined,
                label: 'LOGOUT',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                      title: 'Logout',
                      message: 'Are you sure you want to logout?',
                      primaryButtonLabel: 'Logout',
                      primaryOnPressed: () async {
                        await Supabase.instance.client.auth.signOut();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                      secondaryButtonLabel: 'Cancel',
                    ),
                  );
                },
                isSelected: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({
    super.key,
  });

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  bool _isObscure = true, _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      isLoading: _isLoading,
      title: 'Change Password',
      message: 'Enter new password and confirm password to change the password',
      content: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          children: [
            CustomCard(
              child: TextFormField(
                controller: _passwordController,
                obscureText: _isObscure,
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    return null;
                  } else {
                    return 'Enter password';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _isObscure = !_isObscure;
                      setState(() {});
                    },
                    icon: Icon(
                      _isObscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            CustomCard(
              child: TextFormField(
                controller: _confirmPasswordController,
                obscureText: _isObscure,
                validator: (value) {
                  if (value != null &&
                      value.trim().isNotEmpty &&
                      _passwordController.text.trim() == value) {
                    return null;
                  } else {
                    return "Passwords doesn't match";
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Confirm Password',
                ),
              ),
            ),
          ],
        ),
      ),
      primaryButtonLabel: 'Change',
      primaryOnPressed: () async {
        try {
          if (_formKey.currentState!.validate()) {
            _isLoading = true;
            setState(() {});
            await Supabase.instance.client.auth.updateUser(
              UserAttributes(
                password: _passwordController.text.trim(),
              ),
            );
            _isLoading = false;
            setState(() {});
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          }
        } catch (e) {
          showDialog(
            context: context,
            builder: (context) => CustomAlertDialog(
              title: 'Failed!',
              message: e.toString(),
              primaryButtonLabel: 'Ok',
            ),
          );
        }
      },
      secondaryButtonLabel: 'Cancel',
    );
  }
}
