import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
    this.message,
    this.creatorId,
    this.isMe, {
    this.key,
  });

  final Key key;
  final String message;
  final bool isMe;
  final String creatorId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firestore.instance.collection('users').document(creatorId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }

          final String username = snapshot.data['username'];
          final String userImage = snapshot.data['imageUrl'];

          return Stack(
            children: [
              Row(
                mainAxisAlignment:
                    isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isMe
                          ? Colors.grey[300]
                          : Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(!isMe ? 0 : 12),
                        bottomRight: Radius.circular(!isMe ? 12 : 0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isMe
                                ? Colors.black
                                : Theme.of(context)
                                    .accentTextTheme
                                    .headline1
                                    .color,
                          ),
                        ),
                        Text(
                          message,
                          style: TextStyle(
                            color: isMe
                                ? Colors.black
                                : Theme.of(context)
                                    .accentTextTheme
                                    .headline1
                                    .color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                left: !isMe ? MediaQuery.of(context).size.width * 0.55 : null,
                right: isMe ? MediaQuery.of(context).size.width * 0.55 : null,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(userImage),
                ),
              ),
            ],
            overflow: Overflow.visible,
          );
        });
  }
}
