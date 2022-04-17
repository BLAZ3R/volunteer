import 'package:flutter/material.dart';
import 'package:volunteer/constants/MainTheme.dart';

import 'TextFieldContainer.dart';

class RoundedInputField extends StatelessWidget {
  String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          hintText: hintText,
        ),
        style: MainTheme.of(context).bodyText1,
      ),
    );
  }
}
