import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/chat/chatlist.dart';
import '../widgets/chat/newmessage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final focusnode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          DropdownButton(
              icon: const Icon(Icons.more_vert),
              underline: const SizedBox.shrink(),
              items: [
                DropdownMenuItem(
                  value: 1,
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.exit_to_app),
                    label: const Text('Log out'),
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == 1) {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(
              focusNode: focusnode,
            ),
          ),
          // if (userMessage != '' && userName != '')
          //   ReplyOnSend(message: userMessage, userName: userName),
          NewMessage(focusnode: focusnode),
        ],
      ),
    );
  }
}
