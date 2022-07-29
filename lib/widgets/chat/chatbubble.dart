import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:provider/provider.dart';

import '../../providers/replies.dart';
import 'replyonbubble.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final Key keybuble;
  final String userName;
  final Map? replyed;
  final FocusNode focusNode;
  const ChatBubble({
    Key? key,
    required this.message,
    required this.isMe,
    required this.keybuble,
    required this.userName,
    required this.replyed,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      key: keybuble,
      onLeftSwipe: () {
        focusNode.requestFocus();
        Provider.of<Replies>(context, listen: false).add(message, userName);
      },
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(minWidth: 60, maxWidth: 300),
            decoration: BoxDecoration(
              color: isMe ? Colors.grey[300] : Colors.purple[400],
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(8),
                topRight: const Radius.circular(8),
                bottomLeft:
                    isMe ? const Radius.circular(8) : const Radius.circular(0),
                bottomRight:
                    isMe ? const Radius.circular(0) : const Radius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: isMe
                  ? replyed != null
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (replyed != null)
                  ReplyOnBubble(
                    isMe: isMe,
                    message: replyed!['message'],
                    name: replyed!['name'],
                  ),
                if (replyed != null)
                  Container(
                    height: 1,
                    color:  isMe ?Colors.black12: Colors.white24,
                  ),
                Text(
                  userName,
                  style: TextStyle(color: isMe ? Colors.black : null),
                ),
                Text(
                  message,
                  style: TextStyle(color: isMe ? Colors.black : null),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
