import 'package:flutter/material.dart';

import '../constants/MainTheme.dart';
import 'TextFieldContainer.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  RoundedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: !_passwordVisible,
        onChanged: widget.onChanged,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          hintText: 'Пароль',
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: MainTheme.of(context).primaryText,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
        style: MainTheme.of(context).bodyText1,
      ),
    );
  }
}
