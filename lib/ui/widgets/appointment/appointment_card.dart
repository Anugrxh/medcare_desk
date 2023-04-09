import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcare_desk/blocs/doctor_appointments/doctor_appointments_bloc.dart';
import 'package:medcare_desk/ui/screens/issued_tokens_screen.dart';
import 'package:medcare_desk/ui/widgets/custom_alert_dialog.dart';

import '../../../util/get_age.dart';
import '../../../util/get_number_of_10_minute_blocks.dart';
import '../../../util/postgres_time_to_time_of_day.dart';
import '../custom_action_button.dart';
import '../custom_card.dart';
import 'new_appointment_dialog.dart';

class AppointmentCard extends StatelessWidget {
  final Map<String, dynamic> appointmentDetails;
  final DoctorAppointmentsBloc appointmentsBloc;
  const AppointmentCard({
    super.key,
    required this.appointmentDetails,
    required this.appointmentsBloc,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointmentDetails['department_name'],
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          appointmentDetails['doctor_name'],
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) =>
                            BlocProvider<DoctorAppointmentsBloc>.value(
                          value: appointmentsBloc,
                          child: NewAppointmentDialog(
                            appointment: appointmentDetails,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                  )
                ],
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
                          'Age & Gender',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${getAge(DateTime.parse(appointmentDetails['doctor_dob'].toString()))}  ${appointmentDetails['doctor_sex']}',
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
                          appointmentDetails['doctor_fee'].toString(),
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
              Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Called',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              appointmentDetails['called_tokens'].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '/',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.black26,
                                fontWeight: FontWeight.w900,
                              ),
                    ),
                  ),
                  Expanded(
                    child: Material(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Issued',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              appointmentDetails['issued_tokens'].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
                          'Max. Tokens',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          getNumberOf10MinuteBlocks(
                                  convertPostgresTimeToTimeOfDay(
                                      appointmentDetails['doctor_time_from']),
                                  convertPostgresTimeToTimeOfDay(
                                      appointmentDetails['doctor_time_to']))
                              .toString(),
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  CustomActionButton(
                    iconData: Icons.arrow_outward_sharp,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => IssuedTokensScreen(
                            appointmentDetails: appointmentDetails,
                            appointmentsBloc: appointmentsBloc,
                          ),
                        ),
                      );
                    },
                    label: 'View issued tokens',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
