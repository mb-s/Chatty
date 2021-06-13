import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn, [this.originalImage]);

  final Function(File image) imagePickFn;
  final String originalImage;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void _pickImage(bool sourceIsCam) async {
    final picker = ImagePicker();

    Navigator.of(context).pop();

    final pickedImage = await picker.getImage(
      source: sourceIsCam ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.imagePickFn(_pickedImage);
  }

  void _pickSource() {
    showDialog(
      context: context,
      child: AlertDialog(
        content: Row(
          children: [
            FlatButton.icon(
              label: Text('Camera'),
              icon: Icon(Icons.camera_alt_outlined),
              onPressed: () => _pickImage(true),
            ),
            FlatButton.icon(
              label: Text('Gallery'),
              icon: Icon(Icons.image_outlined),
              onPressed: () => _pickImage(false),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.originalImage != null) {
      return Column(
        children: [
          SizedBox(
            height: 20,
          ),
          CircleAvatar(
            radius: 50,
            backgroundImage: _pickedImage != null
                ? FileImage(_pickedImage)
                : NetworkImage(widget.originalImage),
          ),
          FlatButton(
            textColor: Theme.of(context).primaryColor,
            onPressed: _pickSource,
            child: Text('Change Image'),
          ),
        ],
      );
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
          backgroundColor: Colors.grey,
        ),
        FlatButton(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickSource,
          child: Text('Add Image'),
        ),
      ],
    );
  }
}
