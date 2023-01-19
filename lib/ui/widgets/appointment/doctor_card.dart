
import 'package:flutter/material.dart';

import '../custom_button.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue[200],
      borderRadius: BorderRadius.circular(10),
      elevation: 5,
      child: SizedBox(
        width: 400,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Doctor Name",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Text(
                    "8",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Department",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Text(
                    "10/100",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const Divider(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "12:12 AM to 02:00 PM",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  CustomButton(
                    label: "Add",
                    onPressed: () {},
                    icon: Icons.add,
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
