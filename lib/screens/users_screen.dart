import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/users/user_item.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: FutureBuilder(
          future: Firestore.instance.collection('users').getDocuments(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List usersDetails = [];
            snapshot.data.documents.forEach((user) {
              usersDetails.add({
                'id': user.documentID,
                'username': user['username'],
                'imageUrl': user['imageUrl'],
                'email': user['email'],
              });
            });

            return ListView.builder(
              itemBuilder: (ctx, index) {
                return UserItem(
                  username: usersDetails[index]['username'],
                  email: usersDetails[index]['email'],
                  imageUrl: usersDetails[index]['imageUrl'],
                );
              },
              itemCount: usersDetails.length,
            );
          }),
    );
  }
}
