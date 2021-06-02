import 'package:flutter/material.dart';

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
        ],
      ),
    );
  }
}
