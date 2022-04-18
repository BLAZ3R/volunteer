import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer/data/api/AuthApi.dart';
import 'package:volunteer/logic/blocs/auth/login/login_view.dart';
import 'package:volunteer/screens/authScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volunteer',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: RepositoryProvider(
          create: (context) => AuthApi(), child: LoginView()),
    );
  }
}
