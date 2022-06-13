import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer/components/RoundedButton.dart';
import 'package:volunteer/data/api/UserApi.dart';
import 'package:volunteer/data/models/User.dart';
import 'package:volunteer/data/models/Volunteer.dart';
import 'package:volunteer/logic/util/util.dart';

import '../components/RoundedDateField.dart';
import '../components/RoundedInputField.dart';
import '../components/RoundedPasswordField.dart';
import '../components/RoundedPhoneField.dart';
import '../logic/blocs/user/user_bloc.dart';
import '../logic/blocs/user/user_event.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key, this.volunteer}) : super(key: key);
  Volunteer? volunteer;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? _name;

  String? _sName;

  String? _email;

  String? _phone;

  String? _date;

  String? _password;

  String? _organizationName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _name = widget.volunteer?.firstName;
    _sName = widget.volunteer?.secondName;
    _phone = widget.volunteer?.phoneNumber;
    _date = widget.volunteer?.dateOfBirthday;
    if (widget.volunteer?.roles.first == "ORGANIZER") {
      _organizationName = widget.volunteer?.organizationName;
    } else {
      _organizationName = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              RoundedInputField(
                hintText: "Имя",
                onChanged: (value) {
                  _name = value;
                },
              ),
              RoundedInputField(
                hintText: "Фамилия",
                onChanged: (value) {
                  _sName = value;
                },
              ),
              if (_organizationName != "")
                RoundedInputField(
                  hintText: "Название организации",
                  onChanged: (value) {
                    _organizationName = value;
                  },
                ),
              RoundedPhoneField(
                  hintText: "Введите номер телефона",
                  onChanged: (value) {
                    _phone = value;
                  }),
              RoundedDateField(
                hintText: "Дата рождения день/месяц/год",
                onChanged: (value) {
                  _date = value;
                },
              ),
              RoundedButton(
                  text: "Изменить",
                  press: () async {
                    User volunteer = User(
                        firstName: _name ?? "Test",
                        secondName: _sName ?? "Test",
                        phoneNumber:
                            _phone!.replaceAll(' ', '') ?? "787878787878",
                        dateOfBirthday: _date ?? "11/01/2002");

                    bool val = await UserApi().changeUser(volunteer);
                    if (val) {
                      Navigator.pop(context);
                    } else {
                      showSnackbar(context, "Что-то пошло не так");
                    }
                  })
            ],
          )),
        ),
      ),
    );
  }
}
