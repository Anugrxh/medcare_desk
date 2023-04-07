import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_card.dart';
import '../../widgets/custom_search.dart';
import '../../widgets/dashcard.dart';
import '../../widgets/department_selector.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Today',
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
              DateFormat('EEEE d MMMM y').format(DateTime.now()),
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            const Divider(
              height: 40,
              color: Color.fromARGB(66, 176, 176, 176),
            ),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: const [
                DashCard(
                  iconData: Icons.receipt_outlined,
                  label: 'Total Tokens Today',
                  value: '340',
                ),
                DashCard(
                  iconData: Icons.person_outline,
                  label: 'Total Doctors',
                  value: '26',
                ),
                DashCard(
                  iconData: Icons.category_outlined,
                  label: 'Total Departments',
                  value: '16',
                ),
              ],
            ),
            const Divider(
              height: 40,
              color: Color.fromARGB(66, 176, 176, 176),
            ),
            const Text(
              'Doctors and Tokens Today',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomSearch(
                    onSearch: (value) {},
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                DepartmentSelector(
                  onSelect: (id) {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    CustomCard(
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
                              Text(
                                'Department',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Dr. Some Doctor',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
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
                                    child: Material(
                                      color: Colors.blueGrey[50],
                                      borderRadius: BorderRadius.circular(10),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 15,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '20',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.copyWith(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      '/',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
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
                                          vertical: 15,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '100',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
