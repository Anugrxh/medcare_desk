import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/dashbord/bloc/dashboard_count_bloc.dart';
import '../../../blocs/dashbord/doctors_token_count/doctors_token_count_bloc.dart';
import '../../widgets/custom_action_button.dart';
import '../../widgets/custom_alert_dialog.dart';
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
  final DoctorsTokenCountBloc doctorsTokenCountBloc = DoctorsTokenCountBloc();
  final DashboardCountBloc dashboardCountBloc = DashboardCountBloc();
  String? _query;
  int? _departmentId;

  @override
  void initState() {
    super.initState();
    doctorsTokenCountBloc.add(DoctorsTokenCountEvent());
    dashboardCountBloc.add(DashboardCountEvent());
  }

  void search() {
    doctorsTokenCountBloc.add(
      DoctorsTokenCountEvent(
        query: _query,
        departmentId: _departmentId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<DoctorsTokenCountBloc>.value(
              value: doctorsTokenCountBloc,
            ),
            BlocProvider<DashboardCountBloc>.value(
              value: dashboardCountBloc,
            ),
          ],
          child: BlocConsumer<DashboardCountBloc, DashboardCountState>(
            listener: (context, dashboardState) {
              if (dashboardState is DashboardCountFailureState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Failure',
                    message: dashboardState.message,
                    primaryButtonLabel: 'Ok',
                  ),
                );
              }
            },
            builder: (context, dashboardState) {
              return BlocConsumer<DoctorsTokenCountBloc,
                  DoctorsTokenCountState>(
                listener: (context, state) {
                  if (state is DoctorsTokenCountFailureState) {
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        title: 'Failure',
                        message: state.message,
                        primaryButtonLabel: 'Ok',
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
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
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                      ),
                      const Divider(
                        height: 40,
                        color: Color.fromARGB(66, 176, 176, 176),
                      ),
                      dashboardState is DashboardCountSuccessState
                          ? Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              children: [
                                DashCard(
                                  iconData: Icons.receipt_outlined,
                                  label: 'Total Tokens Today',
                                  value: dashboardState
                                      .dashbordCount['token_count']
                                      .toString(),
                                ),
                                DashCard(
                                  iconData: Icons.person_outline,
                                  label: 'Total Doctors',
                                  value: dashboardState
                                      .dashbordCount['doctor_count']
                                      .toString(),
                                ),
                                DashCard(
                                  iconData: Icons.person_3_outlined,
                                  label: 'Total Patients',
                                  value: dashboardState
                                      .dashbordCount['patient_count']
                                      .toString(),
                                ),
                                DashCard(
                                  iconData: Icons.category_outlined,
                                  label: 'Total Departments',
                                  value: dashboardState
                                      .dashbordCount['department_count']
                                      .toString(),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(height: 20),
                      state is DoctorsTokenCountLoadingState ||
                              dashboardState is DashboardCountLoadingState
                          ? const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                height: 1,
                                child: LinearProgressIndicator(),
                              ),
                            )
                          : const Divider(
                              height: 1,
                              endIndent: 20,
                              indent: 20,
                            ),
                      const SizedBox(height: 20),
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
                              onSearch: (value) {
                                _query = value;
                                search();
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          DepartmentSelector(
                            onSelect: (id) {
                              _departmentId = id == 0 ? null : id;
                              search();
                            },
                          ),
                        ],
                      ),
                      Expanded(
                        child: state is DoctorsTokenCountSuccessState
                            ? state.tokenCounts.isNotEmpty
                                ? SingleChildScrollView(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 10,
                                    ),
                                    child: Wrap(
                                      spacing: 20,
                                      runSpacing: 20,
                                      alignment: WrapAlignment.start,
                                      children: List<Widget>.generate(
                                        state.tokenCounts.length,
                                        (index) => DoctorTokenCountCard(
                                          tokenCountDetails:
                                              state.tokenCounts[index],
                                        ),
                                      ),
                                    ),
                                  )
                                : const Center(child: Text('No Doctors Found!'))
                            : state is DoctorsTokenCountFailureState
                                ? Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomActionButton(
                                          iconData: Icons.replay_outlined,
                                          onPressed: () {
                                            doctorsTokenCountBloc
                                                .add(DoctorsTokenCountEvent());
                                          },
                                          label: 'Retry',
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class DoctorTokenCountCard extends StatelessWidget {
  final Map<String, dynamic> tokenCountDetails;
  const DoctorTokenCountCard({
    super.key,
    required this.tokenCountDetails,
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
              Text(
                tokenCountDetails['department_name'],
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                tokenCountDetails['doctor_name'],
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                            tokenCountDetails['called_tokens_count'].toString(),
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
                          vertical: 15,
                        ),
                        child: Center(
                          child: Text(
                            tokenCountDetails['issued_tokens_count'].toString(),
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
    );
  }
}
