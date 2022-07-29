import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/replies.dart';

class ReplyOnSend extends StatelessWidget {
  final String message;
  final String userName;
  const ReplyOnSend({Key? key, required this.message, required this.userName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: const Icon(
            Icons.reply,
          ),
        ),
        const SizedBox(width: 7,),
        SizedBox(
          width: 313,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                message,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () {
              Provider.of<Replies>(context, listen: false).delete();
            },
            icon: const Icon(Icons.close))
      ],
    );
  }
}
