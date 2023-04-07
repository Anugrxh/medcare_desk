import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/desk/desk_bloc.dart';
import '../custom_action_button.dart';
import '../custom_alert_dialog.dart';
import '../custom_card.dart';
import 'add_edit_desk_dialog.dart';

class DeskCard extends StatelessWidget {
  final DeskBloc deskBloc;
  final Map<String, dynamic> deskDetails;
  const DeskCard({
    super.key,
    required this.deskBloc,
    required this.deskDetails,
  });

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
                          '#${deskDetails['id']}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          deskDetails['name'],
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => BlocProvider<DeskBloc>.value(
                          value: deskBloc,
                          child: AddEditDeskDialog(
                            deskDetails: deskDetails,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: Colors.orange,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => CustomAlertDialog(
                          title: 'Are you sure?',
                          message:
                              'Are you sure you want to delet this desk user? any data associated with this desk user will be deleted as well',
                          primaryButtonLabel: 'Delete',
                          primaryOnPressed: () {
                            deskBloc.add(
                              DeleteDeskEvent(
                                userId: deskDetails['user_id'],
                              ),
                            );
                            Navigator.pop(context);
                          },
                          secondaryButtonLabel: 'Cancel',
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.red,
                    ),
                  ),
                ],
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
                deskDetails['email'],
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
                'Phone Number',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                deskDetails['phone_number'],
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        deskDetails['status'] == 'active'
                            ? 'Active'
                            : 'Blocked',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: deskDetails['status'] == 'active'
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  CustomActionButton(
                    iconData: Icons.block,
                    color: deskDetails['status'] == 'active'
                        ? Colors.red
                        : Colors.green,
                    label:
                        deskDetails['status'] == 'active' ? 'Block' : 'Unblock',
                    onPressed: () {
                      deskBloc.add(
                        ChangeStatusDeskEvent(
                          userId: deskDetails['user_id'],
                          status: deskDetails['status'] == 'active'
                              ? 'blocked'
                              : 'active',
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
