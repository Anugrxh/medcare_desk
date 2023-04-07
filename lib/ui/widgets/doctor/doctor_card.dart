import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/doctor/doctor_bloc.dart';
import '../../../util/get_age.dart';
import '../../../util/get_number_of_10_minute_blocks.dart';
import '../../../util/postgres_time_to_time_of_day.dart';
import '../custom_action_button.dart';
import '../custom_alert_dialog.dart';
import '../custom_card.dart';
import 'add_edit_doctor_dialog.dart';

class DoctorCard extends StatelessWidget {
  final Map<String, dynamic> doctorDetails;
  final DoctorBloc doctorBloc;

  const DoctorCard({
    super.key,
    required this.doctorDetails,
    required this.doctorBloc,
  });

  String getOffDayString(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednessday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Monday';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SizedBox(
        width: 310,
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
                          '#${doctorDetails['id']}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          doctorDetails['name'],
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  // IconButton(
                  //   onPressed: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (context) => BlocProvider<DoctorBloc>.value(
                  //         value: doctorBloc,
                  //         child: AddEditDoctorDialog(
                  //           doctorDetails: doctorDetails,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   icon: const Icon(
                  //     Icons.edit_outlined,
                  //     color: Colors.orange,
                  //   ),
                  // ),
                  // IconButton(
                  //   onPressed: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (_) => CustomAlertDialog(
                  //         title: 'Are you sure?',
                  //         message:
                  //             'Are you sure you want to delet this doctor? any data associated with this doctor will be deleted as well',
                  //         primaryButtonLabel: 'Delete',
                  //         primaryOnPressed: () {
                  //           doctorBloc.add(
                  //             DeleteDoctorEvent(
                  //               userId: doctorDetails['user_id'],
                  //             ),
                  //           );
                  //           Navigator.pop(context);
                  //         },
                  //         secondaryButtonLabel: 'Cancel',
                  //       ),
                  //     );
                  //   },
                  //   icon: const Icon(
                  //     Icons.delete_forever_outlined,
                  //     color: Colors.red,
                  //   ),
                  // ),
                ],
              ),
              const Divider(
                height: 15,
                color: Color.fromARGB(66, 176, 176, 176),
              ),
              Text(
                'Age & Gender',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                '${getAge(DateTime.parse(doctorDetails['dob'].toString()))}  ${doctorDetails['sex']}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Divider(
                height: 15,
                color: Color.fromARGB(66, 176, 176, 176),
              ),
              Text(
                'Department',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                doctorDetails['department'],
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Divider(
                height: 15,
                color: Color.fromARGB(66, 176, 176, 176),
              ),
              Text(
                'Email',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                doctorDetails['email'],
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
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
                          'Phone Number',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          doctorDetails['phone_number'],
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
                          'Off Day',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          getOffDayString(doctorDetails['off_day']),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Time From',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          convertPostgresTimeToTimeOfDay(
                                  doctorDetails['time_from'])
                              .format(context),
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
                          'Time To',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          convertPostgresTimeToTimeOfDay(
                                  doctorDetails['time_to'])
                              .format(context),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Max. Token',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          getNumberOf10MinuteBlocks(
                                  convertPostgresTimeToTimeOfDay(
                                      doctorDetails['time_from']),
                                  convertPostgresTimeToTimeOfDay(
                                      doctorDetails['time_to']))
                              .toString(),
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
                          doctorDetails['fee'].toString(),
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
              // const Divider(
              //   height: 15,
              //   color: Color.fromARGB(66, 176, 176, 176),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'Status',
              //           style:
              //               Theme.of(context).textTheme.labelMedium?.copyWith(
              //                     color: Colors.black45,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //         ),
              //         const SizedBox(height: 5),
              //         Text(
              //           doctorDetails['status'],
              //           style: Theme.of(context).textTheme.titleSmall?.copyWith(
              //                 color: doctorDetails['status'] == 'active'
              //                     ? Colors.green
              //                     : Colors.red,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //         ),
              //       ],
              //     ),
              //     CustomActionButton(
              //       iconData: Icons.block,
              //       color: doctorDetails['status'] == 'active'
              //           ? Colors.red
              //           : Colors.green,
              //       label: doctorDetails['status'] == 'active'
              //           ? 'Block'
              //           : 'Unblock',
              //       onPressed: () {
              //         doctorBloc.add(
              //           ChangeStatusDoctorEvent(
              //             userId: doctorDetails['user_id'],
              //             status: doctorDetails['status'] == 'active'
              //                 ? 'blocked'
              //                 : 'active',
              //           ),
              //         );
              //       },
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
