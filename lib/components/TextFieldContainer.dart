import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
