import 'package:flutter/material.dart';
import 'package:medcare_desk/blocs/doctor_appointments/doctor_appointments_bloc.dart';

import '../../util/get_age.dart';
import '../widgets/custom_action_button.dart';
import '../widgets/custom_alert_dialog.dart';
import '../widgets/token_card.dart';

class IssuedTokensScreen extends StatefulWidget {
  final Map<String, dynamic> appointmentDetails;
  final DoctorAppointmentsBloc appointmentsBloc;
  const IssuedTokensScreen({
    super.key,
    required this.appointmentDetails,
    required this.appointmentsBloc,
  });

  @override
  State<IssuedTokensScreen> createState() => _IssuedTokensScreenState();
}

class _IssuedTokensScreenState extends State<IssuedTokensScreen> {
  Map<String, dynamic>? currentToken;
  List<Map<String, dynamic>> todaysTokens = [];

  @override
  void initState() {
    super.initState();
    setCurrentToken();
    getTodaysAppointments();
  }

  void setCurrentToken() {
    DateTime currentDay = DateTime.now();
    for (int i = 0; i < widget.appointmentDetails['tokens'].length; i++) {
      DateTime bookingDateTime = DateTime.parse(
          widget.appointmentDetails['tokens'][i]['booking_date_time']);
      String status = widget.appointmentDetails['tokens'][i]['status'];

      if ((currentDay.year == bookingDateTime.year &&
          currentDay.month == bookingDateTime.month &&
          currentDay.day == bookingDateTime.day)) {
        if (status != 'pending') {
          currentToken = widget.appointmentDetails['tokens'][i];
        } else {
          break;
        }
      }
    }

    setState(() {});
  }

  void getTodaysAppointments() {
    DateTime currentDay = DateTime.now();

    for (int i = 0; i < widget.appointmentDetails['tokens'].length; i++) {
      DateTime bookingDateTime = DateTime.parse(
          widget.appointmentDetails['tokens'][i]['booking_date_time']);
      String status = widget.appointmentDetails['tokens'][i]['status'];
      if (currentDay.year == bookingDateTime.year &&
          currentDay.month == bookingDateTime.month &&
          currentDay.day == bookingDateTime.day &&
          status == 'pending') {
        todaysTokens.add(widget.appointmentDetails['tokens'][i]);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: const BackButton(
          color: Colors.black54,
        ),
        title: Text(
          'Issued Tokens',
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
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current Token',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        currentToken != null
                            ? currentToken!['number'].toString()
                            : '0',
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                    child: VerticalDivider(
                      width: 100,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current Patient',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        currentToken != null
                            ? currentToken!['patient']['name'].toString()
                            : 'Not Called',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        currentToken != null
                            ? '${getAge(DateTime.parse(currentToken!['patient']['dob'].toString()))}  ${currentToken!['patient']['sex']}'
                            : '',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  currentToken != null
                      ? CustomActionButton(
                          iconData: Icons.arrow_outward,
                          onPressed: () {},
                          label: 'Patient Details',
                        )
                      : const SizedBox(),
                ],
              ),
              const Divider(
                height: 40,
                color: Color.fromARGB(66, 176, 176, 176),
              ),
              const Text(
                'Upcoming Tokens',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                  fontSize: 15,
                ),
              ),
              Expanded(
                child: todaysTokens.isNotEmpty
                    ? SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        child: Wrap(
                          spacing: 15,
                          runSpacing: 15,
                          children: List<Widget>.generate(
                            todaysTokens.length,
                            (index) => TokenCard(
                              tokenDetails: todaysTokens[index],
                              onDeletePressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => CustomAlertDialog(
                                    title: 'Delete?',
                                    message:
                                        'Are you sure you want to delete this appointment?',
                                    primaryButtonLabel: 'Delete',
                                    primaryOnPressed: () {
                                      widget.appointmentsBloc.add(
                                        DeleteDoctorAppointmentEvent(
                                          appointmentId: todaysTokens[index]
                                              ['id'],
                                        ),
                                      );

                                      todaysTokens.remove(todaysTokens[index]);
                                      setState(() {});

                                      Navigator.of(context).pop();
                                    },
                                    secondaryButtonLabel: 'Cancel',
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    : const Center(child: Text('No Appointments Today!')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
