import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcare_desk/ui/widgets/custom_alert_dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../blocs/auth/sign_in/sign_in_bloc.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (Supabase.instance.client.auth.currentUser != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "asset/image/bg.png",
              fit: BoxFit.cover,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Image.asset(
                  "asset/image/weca.png",
                ),
              ),
              Expanded(
                child: BlocProvider<SignInBloc>(
                  create: (context) => SignInBloc(),
                  child: BlocConsumer<SignInBloc, SignInState>(
                    listener: (context, state) {
                      if (state is SignInFailureState) {
                        showDialog(
                          context: context,
                          builder: (context) => const CustomAlertDialog(
                            title: 'Failure',
                            message:
                                'Please check your email and password and try again.',
                            primaryButtonLabel: 'Ok',
                          ),
                        );
                      } else if (state is SignInSuccessState) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Home(),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Form(
                        key: formKey,
                        child: Center(
                          child: SizedBox(
                            width: 360,
                            child: CustomCard(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 20,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "MEDCARE",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Login",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            color: const Color.fromARGB(
                                                255, 0, 5, 10),
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Enter your email and password to login.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: const Color.fromARGB(
                                                255, 0, 5, 10),
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 300,
                                      child: TextFormField(
                                        controller: _emailController,
                                        obscureText: false,
                                        validator: (value) {
                                          if (value != null &&
                                              value.isNotEmpty) {
                                            return null;
                                          } else {
                                            return "Please enter an email";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          labelText: 'Email',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 300,
                                      child: TextFormField(
                                        controller: _passwordController,
                                        obscureText: _isObscure,
                                        validator: (value) {
                                          if (value != null &&
                                              value.isNotEmpty) {
                                            return null;
                                          } else {
                                            return "Please enter password";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              _isObscure = !_isObscure;
                                              setState(() {});
                                            },
                                            icon: Icon(
                                              _isObscure
                                                  ? Icons
                                                      .visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelText: 'Password',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: CustomButton(
                                        label: "Login",
                                        buttonColor: Colors.white,
                                        elevation: 5,
                                        isLoading: state is SignInLoadingState,
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            String email =
                                                _emailController.text.trim();
                                            String password =
                                                _passwordController.text.trim();

                                            BlocProvider.of<SignInBloc>(context)
                                                .add(
                                              SignInEvent(
                                                email: email,
                                                password: password,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
