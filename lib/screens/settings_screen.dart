import 'package:flutter/material.dart';

import '../widgets/settings/settings_item.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SettingsItem(
            Icons.account_circle_outlined,
            'User settings',
          ),
          SettingsItem(
            Icons.color_lens_outlined,
            'Theme',
          ),
          SettingsItem(
            Icons.delete_forever_outlined,
            'Delete account',
          ),
        ],
      ),
    );
  }
}
