import 'package:chatapp/providers/replies.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import './screens/authscreen.dart';
import './screens/chatscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Replies(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chat App',
          theme: ThemeData(
            colorScheme: const ColorScheme.dark(),
            appBarTheme: const AppBarTheme(backgroundColor: Colors.black12),
            fontFamily: 'Poppins',
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const ChatScreen();
              }
              return const AuthScreen();
            },
          ),
        ));
  }
}
