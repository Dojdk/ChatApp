import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chatbubble.dart';
import 'imageinchat.dart';

class ChatList extends StatelessWidget {
  final FocusNode focusNode;
  const ChatList({
    Key? key,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // if (snapshot.data!.docs.isEmpty) {
          //   return const Center(
          //     child: Text('NO MESAGES YET...'),
          //   );
          // }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            reverse: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final chatDocs = snapshot.data!.docs[index];
              if (chatDocs['imageUrl'] != null) {
                return ImageInChat(
                  keyimage: ValueKey(chatDocs.id),
                  url: chatDocs['imageUrl'],
                  isMe: chatDocs['userId'] ==
                      FirebaseAuth.instance.currentUser!.uid,
                );
              }
              return ChatBubble(
                message: chatDocs['text'],
                isMe: chatDocs['userId'] ==
                    FirebaseAuth.instance.currentUser!.uid,
                keybuble: ValueKey(chatDocs.id),
                userName: chatDocs['userName'],
                replyed: chatDocs['replyOn'],
                focusNode: focusNode,
              );
            },
          );
        },
      ),
    );
  }
}
