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

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.imagePickFn(_pickedImage);
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
          FlatButton.icon(
            textColor: Theme.of(context).primaryColor,
            onPressed: _pickImage,
            icon: Icon(Icons.camera_alt_outlined),
            label: Text('Change Image'),
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
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          icon: Icon(Icons.camera_alt_outlined),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
