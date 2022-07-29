import 'package:flutter/cupertino.dart';

import '../models/reply.dart';

class Replies with ChangeNotifier {
  List<Reply> _replylist = [];

  void add(String message, String name) {
    _replylist = [Reply(message, name)];
    notifyListeners();
  }

  void delete() {
    _replylist = [];
    notifyListeners();
  }

  bool isEmpty() {
    return _replylist.isEmpty;
  }

  String get name {
    if (isEmpty()) {
      return '';
    }
    return _replylist.first.userName;
  }

  String get message {
    if (isEmpty()) {
      return '';
    }
    return _replylist.first.message;
  }
}
