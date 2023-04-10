import 'package:flutter/material.dart';
import 'package:medcare_desk/ui/screens/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://nrkcnsvzixpxysgqcrfd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5ya2Nuc3Z6aXhweHlzZ3FjcmZkIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzcwNTg2MTksImV4cCI6MTk5MjYzNDYxOX0.es7MQlF1L_bAoQ-DuaOeXhwdtWjKyFthvglP54EUqPk',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
      ),
      home: const Login(),
    );
  }
}
