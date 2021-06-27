import 'dart:math';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
              transform: Matrix4.rotationZ(-6 * pi / 180)..translate(-10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).backgroundColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black26,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Text(
                'Chatty',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 40,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Text('Loading...'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: LinearProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
