import 'package:flutter/material.dart';

class ReplyOnBubble extends StatelessWidget {
  final String message;
  final String name;
  final bool isMe;
  
  const ReplyOnBubble(
      {Key? key, required this.message, required this.name, required this.isMe,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: 1, height: 35, color: isMe ? Colors.black : Colors.white),
        const SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(color: isMe ? Colors.black : null),
            ),
            Container(
              constraints: const BoxConstraints(minWidth: 0, maxWidth: 278),
              child: Text(
                message,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(color: isMe ? Colors.black : null),
              ),

            ),
            
          ],
        ),
      ],
    );
  }
}
