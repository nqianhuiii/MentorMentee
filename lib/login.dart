import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      const alert = AlertDialog(
        title: Text("Error sign in"),
        content: Text("Wrong username or password"),
      );
      return showDialog(
        // use context because:
        // 1. navigator
        // 2. retrieve theme data
        // 3. call overlay widget 
        context: context, 
        builder: (context)=>alert);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('LOGIN TO YOUR APP',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30)),
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5.0)),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Email: '),
              TextField(
                decoration:
                    const InputDecoration(prefixIcon: Icon(Icons.person)),
                controller: _emailController,
              ),
              const SizedBox(height: 12),
              const Text('Password: '),
              TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration:
                      const InputDecoration(prefixIcon: Icon(Icons.security))),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: login, child: const Text('Login')),
            ]),
          ),
        ],
      ),
    );
  }
}

