import 'package:flutter/material.dart';

import '../widgets/settings/settings_item.dart';
import '../widgets/settings/user_settings.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          UserSettings(),
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
