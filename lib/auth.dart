import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';

import 'login.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance
          .authStateChanges(), // notify user about changes to the sign-in state
      builder: ((context, snapshot) { // snapshot is a collection of metadata
        if (snapshot.hasData) {
          return const Home();
        } else {
          return const MyLoginPage(
            title: 'My Login Page'
          );
        }
      }),
    ));
  }
}
