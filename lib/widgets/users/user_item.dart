import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final String imageUrl;
  final String username;
  final String email;

  UserItem({this.username, this.imageUrl, this.email});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(username),
      subtitle: Text(email),
    );
  }
}
