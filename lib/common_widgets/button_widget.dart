import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Function onTap;
  final Color? buttonColor;
  final Color? textColor;

  const ButtonWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: key,
        onTap: () {
          // onClick function
          onTap();
        },
        child: Ink(
          decoration: BoxDecoration(
              color: buttonColor ?? Colors.black,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 12, color: textColor ?? Colors.white),
          ),
        ),
      ),
    );
  }
}
