import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcare_desk/util/value_validators.dart';

import '../../../blocs/desk/desk_bloc.dart';
import '../custom_button.dart';
import '../custom_card.dart';
import '../department_selector.dart';
import '../custom_time_picker.dart';

class AddEditDeskDialog extends StatefulWidget {
  final Map<String, dynamic>? deskDetails;
  const AddEditDeskDialog({
    super.key,
    this.deskDetails,
  });

  @override
  State<AddEditDeskDialog> createState() => _AddEditDeskDialogState();
}

class _AddEditDeskDialogState extends State<AddEditDeskDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool _isObscure = true;

  @override
  void initState() {
    if (widget.deskDetails != null) {
      _nameController.text = widget.deskDetails!['name'];
      _emailController.text = widget.deskDetails!['email'];
      _phoneNumberController.text = widget.deskDetails!['phone_number'];
    }
    super.initState();
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
            key: _formKey,
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
                            widget.deskDetails != null
                                ? "Edit Desk User"
                                : "Add Desk User",
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
                            widget.deskDetails != null
                                ? "Change the following details and save to apply them"
                                : "Enter the following details to add a desk user.",
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
                  'Desk User Name',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomCard(
                  child: TextFormField(
                    controller: _nameController,
                    validator: alphanumericWithSpaceValidator,
                    decoration: const InputDecoration(
                      hintText: 'eg. Mr.John',
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
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
                CustomCard(
                  child: TextFormField(
                    controller: _emailController,
                    validator: emailValidator,
                    decoration: const InputDecoration(
                      hintText: 'eg.deskuser@medcare.com',
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Text(
                  'Passward',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomCard(
                  child: TextFormField(
                    obscureText: _isObscure,
                    controller: _passwordController,
                    validator: widget.deskDetails != null
                        ? (value) {
                            return null;
                          }
                        : passwordValidator,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          _isObscure = !_isObscure;
                          setState(() {});
                        },
                        icon: Icon(
                          _isObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                      hintText: 'Password',
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
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
                CustomCard(
                  child: TextFormField(
                    controller: _phoneNumberController,
                    validator: phoneNumberValidator,
                    decoration: const InputDecoration(
                      hintText: 'eg. 9876543210',
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                CustomButton(
                  label: widget.deskDetails != null ? 'Save' : 'Add',
                  labelColor: Colors.white,
                  buttonColor: Colors.blue,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.deskDetails != null) {
                        BlocProvider.of<DeskBloc>(context).add(
                          EditDeskEvent(
                            userId: widget.deskDetails!['user_id'],
                            name: _nameController.text.trim(),
                            phone: _phoneNumberController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim().isNotEmpty
                                ? _passwordController.text.trim()
                                : null,
                          ),
                        );
                      } else {
                        BlocProvider.of<DeskBloc>(context).add(
                          AddDeskEvent(
                            name: _nameController.text.trim(),
                            phone: _phoneNumberController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          ),
                        );
                      }

                      Navigator.pop(context);
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
