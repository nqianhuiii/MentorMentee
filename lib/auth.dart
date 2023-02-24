import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart'; //another form of import other than like the below one
import 'package:google_sign_in/google_sign_in.dart';
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
      builder: ((context, snapshot) {
        // snapshot is a collection of metadata
        if (snapshot.hasData) {
          return const Home(); // return to homepage if have data existed
          // return const MyLoginPage(title: 'My Login Page');
        } else {
          return const MyLoginPage(title: 'My Login Page');
        }
      }),
    ));
  }
}

