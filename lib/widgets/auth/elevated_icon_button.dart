import 'package:flutter/material.dart';

class ElevatedIconButton extends StatelessWidget {
  const ElevatedIconButton(
      {Key? key,
      required this.onPressed,
      required this.icon,
      required this.label})
      : super(key: key);
  final void Function() onPressed;
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>((Colors.white.withOpacity(0.8))),
          // side: MaterialStateProperty.all<BorderSide>(BorderSide)
        ),
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.red,
        ),
        label: Text(
          label,
          style: const TextStyle(color: Colors.black),
        ));
  }
}
