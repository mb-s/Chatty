import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/chat_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';
import './screens/user_settings_screen.dart';
import './screens/users_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatty',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.indigo[600],
        backgroundColor: Colors.red[200],
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.teal,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (ctx) => StreamBuilder(
              stream: FirebaseAuth.instance.onAuthStateChanged,
              builder: (ctx, userSanpshot) {
                if (userSanpshot.connectionState == ConnectionState.waiting) {
                  return SplashScreen();
                }
                if (userSanpshot.hasData) {
                  return ChatScreen();
                }
                return AuthScreen();
              },
            ),
        '/user-settings': (ctx) => UserSettingsScreen(),
        '/users': (ctx) => UsersScreen(),
      },
    );
  }
}
