import 'package:flutter/material.dart';
import 'package:volunteer/components/RoundedButton.dart';
import 'package:volunteer/components/RoundedInputField.dart';
import 'package:volunteer/components/RoundedPasswordField.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
    final _formKey = GlobalKey<FormState>();
  late String name;
  late String email;
  late String phone;
  late DateTime date;
  late String password;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              RoundedInputField(
                hintText: "ФИО", onChanged: (value) {

                },
                validator: (value) =>
              ? null : 'Пароль слишком короткий',),
              RoundedInputField(hintText: "Почта", onChanged: (value) {}),
              RoundedInputField(hintText: "+7 ( )", onChanged: (value) {}),
              RoundedInputField(hintText: "Дата рождения", onChanged: (value) {}),
              RoundedPasswordField(onChanged: (value) {}),
              RoundedButton(text: "Регистрация", press: () {}),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context); 
                    },
                    child: Text(
                      "Уже есть аккаунт?",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
