import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/auth/form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  Future<void> _submitAuthForm(
    String email,
    String username,
    String password,
    bool login,
    BuildContext ctx,
  ) async {
    UserCredential usercredential;
    try {
      setState(() {
        _isLoading = true;
      });
      if (login) {
        usercredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        usercredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(usercredential.user!.uid)
            .set({
          'username': username,
          'email': email,
        });
      }
    } on FirebaseException catch (error) {
      var message = 'Error occured';

      if (error.message != null) {
        message = error.message!;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(message)));
    } catch (error) {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(const SnackBar(content: Text('message')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: AuthForm(submit: _submitAuthForm,isLoading: _isLoading),
      ),
    );
  }
}
