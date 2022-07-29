import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../providers/replies.dart';

import 'replyonsend.dart';

class NewMessage extends StatefulWidget {
  final FocusNode focusnode;
  const NewMessage({Key? key, required this.focusnode}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  Map replyed = {};
  File? _filecontroller;
  String _enteredMessage = '';
  final _textController = TextEditingController();
  Future<void> _sendMessage() async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'userName': userData['username'],
      'replyOn': replyed.isEmpty ? null : replyed,
      'imageUrl': null
    });
    setState(() {
      _enteredMessage = '';
    });
    _textController.clear();
  }

  Future<void> _takeimage() async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    final picker = ImagePicker();
    final imagefile = await picker.pickImage(source: ImageSource.gallery);
    if (imagefile == null) {
      return;
    }
    _filecontroller = File(imagefile.path);

    final String filename = const Uuid().v1();

    var ref =
        FirebaseStorage.instance.ref().child('images').child('$filename.jpg');

    var uploadTask = await ref.putFile(_filecontroller!);

    String imageUrl = await uploadTask.ref.getDownloadURL();

    FirebaseFirestore.instance.collection('chat').add({
      'createdAt': Timestamp.now(),
      'text':'',
      'userId': user.uid,
      'replyOn':null,
      'userName': userData['username'],
      'imageUrl': imageUrl
    });
    _filecontroller=null;
  }

  @override
  Widget build(BuildContext context) {
    final replies = Provider.of<Replies>(context);
    return Column(
      children: [
        if (!replies.isEmpty())
          ReplyOnSend(message: replies.message, userName: replies.name),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                color: Theme.of(context).colorScheme.primary,
                onPressed: _takeimage,
                icon: const Icon(Icons.image),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: TextField(
                  focusNode: widget.focusnode,
                  controller: _textController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Send a message',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  onChanged: ((value) {
                    setState(() {
                      _enteredMessage = value;
                    });
                  }),
                ),
              ),
              IconButton(
                onPressed: _enteredMessage.trim().isEmpty
                    ? null
                    : () {
                        !replies.isEmpty()
                            ? replyed = {
                                'name': replies.name,
                                'message': replies.message
                              }
                            : replyed = {};
                        _sendMessage();
                        replies.delete();
                      },
                icon: const Icon(
                  Icons.send,
                ),
                color: Theme.of(context).colorScheme.primary,
              )
            ],
          ),
        ),
      ],
    );
  }
}
