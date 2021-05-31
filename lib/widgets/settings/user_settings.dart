import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../pickers/user_image_picker.dart';

class UserSettings extends StatefulWidget {
  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  File _newUserImage;
  TextEditingController _userNameController = new TextEditingController();
  final _userNameKey = GlobalKey<FormState>();

  void _pickedImage(File image) {
    _newUserImage = image;
  }

  void _updateUserDetails(String id, String username) async {
    FocusScope.of(context).unfocus();
    if (_userNameController.text.trim().isEmpty ||
        _userNameController.text.trim().length < 4) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Username must be at least 4 characters.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    try {
      if (_newUserImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(id + '.jpg');

        await ref.putFile(_newUserImage).onComplete;
        final imageUrl = await ref.getDownloadURL();

        await Firestore.instance.collection('users').document(id).updateData(
          {
            'imageUrl': imageUrl,
            'username': _userNameController.text.trim(),
          },
        );

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      } else if (_userNameController.text.trim() != username) {
        await Firestore.instance.collection('users').document(id).updateData(
          {
            'username': _userNameController.text.trim(),
          },
        );

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      }
    } on PlatformException catch (error) {
      var message = 'An error occurred. Please check your credentials.';

      if (error != null) {
        message = error.message;
      }

      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, authsnapshot) {
        if (authsnapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator();
        }
        final id = authsnapshot.data.uid;
        return FutureBuilder(
          future: Firestore.instance.collection('users').document(id).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LinearProgressIndicator();
            }
            final imageUrl = snapshot.data['imageUrl'];
            final username = snapshot.data['username'];
            final userEmail = snapshot.data['email'];

            _userNameController.text = username;

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  UserImagePicker(
                    _pickedImage,
                    imageUrl,
                  ),
                  TextField(
                    key: _userNameKey,
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                    autocorrect: true,
                    controller: _userNameController,
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: false,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    controller: new TextEditingController(text: userEmail),
                    readOnly: true,
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    child: Text('Update'),
                    onPressed: () => _updateUserDetails(id, username),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
