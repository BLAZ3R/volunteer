import 'package:flutter/material.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:volunteer/components/RoundedButton.dart';
import 'package:volunteer/components/RoundedInputField.dart';
import 'package:volunteer/components/RoundedPasswordField.dart';
import 'package:volunteer/components/RoundedPhoneField.dart';
import 'package:volunteer/components/TextFieldContainer.dart';
import 'package:volunteer/data/api/AuthApi.dart';
import 'package:volunteer/logic/util/util.dart';

import '../constants/MainTheme.dart';
import '../data/models/User.dart';
import 'navbarScreen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _sName;
  late String _email;
  late String _phone;
  late String _date;
  late String _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _name = "";
    _sName = "";
    _email = "";
    _phone = "";
    _date = "";
    _password = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                RoundedInputField(
                  hintText: "Имя",
                  onChanged: (value) {
                    _name = value;
                  },
                  validator: (value) =>
                      _name.length > 1 ? null : 'Заполните поле',
                ),
                RoundedInputField(
                  hintText: "Фамилия",
                  onChanged: (value) {
                    _sName = value;
                  },
                  validator: (value) =>
                      _sName.length > 1 ? null : 'Заполните поле',
                ),
                RoundedInputField(
                  hintText: "Почта",
                  onChanged: (value) {
                    _email = value;
                  },
                  validator: (value) =>
                      RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(_email)
                          ? null
                          : 'Введи почтовый адрес правильно',
                ),
                RoundedPhoneField(
                    hintText: "Введите номер телефона",
                    validator: (value) =>
                        _phone.length > 11 ? null : 'Заполните поле',
                    onChanged: (value) {
                      _phone = value;
                    }),
                RoundedInputField(
                  hintText: "Дата рождения",
                  onChanged: (value) {
                    _date = value;
                  },
                  validator: (value) =>
                      _date.length > 1 ? null : 'Заполните дату рождения',
                ),
                RoundedPasswordField(
                  onChanged: (value) {
                    _password = value;
                  },
                  validator: (value) =>
                      _password.length >= 6 ? null : "Пароль слишком короткий",
                ),
                RoundedButton(
                    text: "РЕГИСТРАЦИЯ",
                    press: () async {
                      print(_phone.replaceAll(' ', ''));
                      if (_formKey.currentState!.validate()) {
                        User user = User(
                            email: _email,
                            firstName: _name,
                            secondName: _sName,
                            password: _password,
                            dateOfBirthday: _date,
                            phoneNumber: _phone.replaceAll(' ', ''));
                        bool result = await AuthApi().createVolunteer(user);
                        if (result) {
                          Navigator.pop(context);
                          showSnackbar(context, "Аккаунт создан");
                        } else {
                          showSnackbar(context, "Ошибка");
                        }
                      }
                    }),
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
        ),
      )),
    );
  }
}
