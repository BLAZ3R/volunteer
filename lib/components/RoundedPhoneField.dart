import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:volunteer/constants/MainTheme.dart';

import 'TextFieldContainer.dart';

class RoundedPhoneField extends StatelessWidget {
  String hintText;
  final IconData icon;
  FormFieldValidator<String>? validator;
  final ValueChanged<String> onChanged;

  RoundedPhoneField({
    Key? key,
    required this.hintText,
    this.validator,
    this.icon = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  final maskFormatter = MaskTextInputFormatter(
    mask: '7 ### ### ## ##',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        inputFormatters: [maskFormatter],
        cursorColor: Colors.black,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
          ),
          hintText: hintText,
        ),
        style: MainTheme.of(context).bodyText1,
      ),
    );
  }
}
