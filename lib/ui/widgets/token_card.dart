import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../util/get_age.dart';
import '../screens/patient_details_screen.dart';
import 'custom_action_button.dart';
import 'custom_card.dart';

class TokenCard extends StatelessWidget {
  final Map<String, dynamic> tokenDetails;
  final Function() onDeletePressed;
  const TokenCard({
    super.key,
    required this.tokenDetails,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SizedBox(
        width: 312.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '#${tokenDetails['patient']['id']}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          tokenDetails['patient']['name'],
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const Divider(
                          height: 20,
                          endIndent: 150,
                        ),
                        Text(
                          '${getAge(DateTime.parse(tokenDetails['patient']['dob'].toString()))}  ${tokenDetails['patient']['sex']}',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    tokenDetails['number'].toString(),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const Divider(
                height: 20,
                color: Color.fromARGB(66, 176, 176, 176),
              ),
              Text(
                'Booking Date Time',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                DateFormat('dd/MM/yyyy hh:mm a')
                    .format(DateTime.parse(tokenDetails['booking_date_time'])),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Divider(
                height: 20,
                color: Color.fromARGB(66, 176, 176, 176),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: onDeletePressed,
                    icon: const Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                    child: CustomActionButton(
                      iconData: Icons.arrow_outward,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PatientDetailsScreen(
                              patientDetails: tokenDetails['patient'],
                            ),
                          ),
                        );
                      },
                      label: 'Patient Details',
                    ),
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
