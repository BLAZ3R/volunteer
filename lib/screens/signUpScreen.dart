import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:volunteer/components/RoundedButton.dart';
import 'package:volunteer/components/RoundedInputField.dart';
import 'package:volunteer/components/RoundedPasswordField.dart';
import 'package:volunteer/components/RoundedPhoneField.dart';
import 'package:volunteer/components/TextFieldContainer.dart';
import 'package:volunteer/data/api/AuthApi.dart';
import 'package:volunteer/logic/util/util.dart';

import '../components/RoundedDateField.dart';
import '../constants/MainTheme.dart';
import '../data/models/User.dart';
import 'navbarScreen.dart';

final maskFormatter = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {
    "#": RegExp(r'[0-9]'),
  },
);

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
  int? _index;
  late String _date;
  late String _password;
  late String _organizationName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _index = 0;
    _name = "";
    _sName = "";
    _email = "";
    _phone = "";
    _date = "";
    _password = "";
    _organizationName = "";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          setState(() {
                            _index = 0;
                          });
                        },
                        child: Container(
                          width: _index == 0
                              ? size.width * 0.45
                              : size.width * 0.43,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _index == 0 ? Colors.white : Colors.grey,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text('????????????????',
                                textAlign: TextAlign.center,
                                style: MainTheme.of(context).bodyText1),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            _index = 1;
                          });
                        },
                        child: Container(
                          width: _index == 1
                              ? size.width * 0.45
                              : size.width * 0.43,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _index == 1 ? Colors.white : Colors.grey,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text('??????????????????????',
                                textAlign: TextAlign.center,
                                style: MainTheme.of(context).bodyText1),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                RoundedInputField(
                  hintText: "??????",
                  onChanged: (value) {
                    _name = value;
                  },
                  validator: (value) =>
                      _name.length > 1 ? null : '?????????????????? ????????',
                ),
                RoundedInputField(
                  hintText: "??????????????",
                  onChanged: (value) {
                    _sName = value;
                  },
                  validator: (value) =>
                      _sName.length > 1 ? null : '?????????????????? ????????',
                ),
                if (_index == 1)
                  RoundedInputField(
                    hintText: "???????????????? ??????????????????????",
                    onChanged: (value) {
                      _organizationName = value;
                    },
                    validator: (value) => _organizationName.length > 1
                        ? null
                        : '?????????????????? ???????????????? ??????????????????????',
                  ),
                RoundedInputField(
                  hintText: "??????????",
                  onChanged: (value) {
                    _email = value;
                  },
                  validator: (value) =>
                      RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(_email)
                          ? null
                          : '?????????? ???????????????? ?????????? ??????????????????',
                ),
                RoundedPhoneField(
                    hintText: "?????????????? ?????????? ????????????????",
                    validator: (value) =>
                        _phone.length > 11 ? null : '?????????????????? ????????',
                    onChanged: (value) {
                      _phone = value;
                    }),
                RoundedDateField(
                  hintText: "???????? ???????????????? ????????/??????????/??????",
                  onChanged: (value) {
                    _date = value;
                  },
                  validator: (value) =>
                      _date.length > 1 ? null : '?????????????????? ???????? ????????????????',
                ),
                RoundedPasswordField(
                  onChanged: (value) {
                    _password = value;
                  },
                  validator: (value) =>
                      _password.length >= 6 ? null : "???????????? ?????????????? ????????????????",
                ),
                RoundedButton(
                    text: "??????????????????????",
                    press: () async {
                      print(_phone.replaceAll(' ', ''));
                      if (_formKey.currentState!.validate()) {
                        User user = User(
                            email: _email,
                            firstName: _name,
                            secondName: _sName,
                            password: _password,
                            dateOfBirthday: _date,
                            organizationName: _organizationName,
                            phoneNumber: _phone.replaceAll(' ', ''));

                        bool result = _index == 0
                            ? await AuthApi().createVolunteer(user)
                            : await AuthApi().createOrganization(user);
                        if (result) {
                          Navigator.pop(context);
                          showSnackbar(context, "?????????????? ????????????");
                        } else {
                          showSnackbar(context, "????????????");
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
                        "?????? ???????? ???????????????",
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
