import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/patients/manage_patients/manage_patients_bloc.dart';
import '../custom_alert_dialog.dart';
import '../custom_button.dart';
import '../custom_card.dart';
import '../custom_date_picker.dart';
import '../gender_selector.dart';

class AddEditPatientDialog extends StatefulWidget {
  final Map<String, dynamic>? patientData;
  const AddEditPatientDialog({
    super.key,
    this.patientData,
  });

  @override
  State<AddEditPatientDialog> createState() => _AddEditPatientDialogState();
}

class _AddEditPatientDialogState extends State<AddEditPatientDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  DateTime? _dob;
  String _gender = 'male';

  @override
  void initState() {
    super.initState();

    if (widget.patientData != null) {
      _nameController.text = widget.patientData!['name'];
      _phoneController.text = widget.patientData!['phone_number'];
      _dob = DateTime.parse(widget.patientData!['dob']);
      _gender = widget.patientData!['sex'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          width: 1,
          color: Colors.black26,
        ),
      ),
      child: SizedBox(
        width: 400,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.patientData != null
                                ? 'Edit Patient'
                                : "Add Patient",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.patientData != null
                                ? 'Edit the follwoing details and save the details'
                                : "Enter the following details to add a patient.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.black,
                                ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Text(
                  'Name',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomCard(
                  child: TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value != null && value.trim().isNotEmpty) {
                        return null;
                      } else {
                        return 'Please enter Name';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'eg. Mr.John',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Phone Number',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomCard(
                  child: TextFormField(
                    controller: _phoneController,
                    validator: (value) {
                      if (value != null && value.trim().isNotEmpty) {
                        return null;
                      } else {
                        return 'Please enter Phone Number';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'eg. 9876543210',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Date of Birth',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomDatePicker(
                  defaultDate: _dob,
                  onPick: (date) {
                    _dob = date;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Gender',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                GenderSelector(
                  selected: _gender,
                  onSelect: (gender) {
                    _gender = gender;
                  },
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                CustomButton(
                  label: widget.patientData != null ? 'Save' : 'Add',
                  labelColor: Colors.white,
                  buttonColor: Colors.blue,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (_dob != null) {
                        if (widget.patientData != null) {
                          BlocProvider.of<ManagePatientsBloc>(context).add(
                            EditPatientEvent(
                              patientId: widget.patientData!['id'],
                              name: _nameController.text.trim(),
                              sex: _gender,
                              phoneNumber: _phoneController.text.trim(),
                              dob: _dob!,
                            ),
                          );
                        } else {
                          BlocProvider.of<ManagePatientsBloc>(context).add(
                            AddPatientEvent(
                              name: _nameController.text.trim(),
                              sex: _gender,
                              phoneNumber: _phoneController.text.trim(),
                              dob: _dob!,
                            ),
                          );
                        }
                        Navigator.pop(context);
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => const CustomAlertDialog(
                            title: 'Required!',
                            message:
                                'Date of Birth is required, please select the Date of Birth',
                            primaryButtonLabel: 'Ok',
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
