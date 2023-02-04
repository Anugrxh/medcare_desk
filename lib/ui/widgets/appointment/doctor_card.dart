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
                              width: 600,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Doctor Info",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    thickness: 2,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "patient",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomButton(
                                      label: "Select",
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                              child: SizedBox(
                                                width: 600,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        suffixIcon: const Icon(
                                                            Icons.search),
                                                        labelText: 'Search',
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          borderSide:
                                                              const BorderSide(),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      buttonColor: Colors.blue,
                                      elevation: 2),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    thickness: 2,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "time",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomButton(
                                      label: "Today 9pm",
                                      onPressed: () {},
                                      buttonColor: Colors.blue,
                                      elevation: 2),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomButton(
                                      label: "Date",
                                      onPressed: () {},
                                      buttonColor: Colors.blue,
                                      elevation: 2),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
