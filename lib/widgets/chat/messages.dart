import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        return FutureBuilder(
          future: Future.wait(
              [FirebaseAuth.instance.currentUser(), Firestore.instance.collection('users').getDocuments()]),
          builder: (ctx, futureSnapshot) {
            if (futureSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            Map usersDetails = {};
            futureSnapshot.data[1].documents.forEach((user) {
              usersDetails[user.documentID] = {
                'username': user['username'],
                'imageUrl': user['imageUrl'],
              };
            });

            return StreamBuilder(
              stream: Firestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctx, chatSnapshot) {
                if (chatSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final chatDocs = chatSnapshot.data.documents;

                return ListView.builder(
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (ctx, index) => MessageBubble(
                    chatDocs[index]['text'],
                    usersDetails[chatDocs[index]['userId']]['username'],
                    usersDetails[chatDocs[index]['userId']]['imageUrl'],
                    chatDocs[index]['userId'] == futureSnapshot.data[0].uid,
                    key: ValueKey(chatDocs[index].documentID),
                  ),
                );
              },
            );
          },
        );
  }
}
