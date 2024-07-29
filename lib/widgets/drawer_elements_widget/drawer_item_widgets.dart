import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DrawerItems extends StatelessWidget {
  DrawerItems(
      {super.key,
      required this.icon,
      required this.text,
      required this.onClick});
  final IconData icon;
  final String text;
  VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
        onTap: onClick,
      ),
    );
  }
}
