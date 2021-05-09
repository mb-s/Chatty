import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  SettingsItem(this.icon, this.title);

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }
}
