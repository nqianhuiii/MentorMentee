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
      // ignore: avoid_print
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
          builder: (context) => alert);
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.security))),

                const SizedBox(height: 15),

                ElevatedButton(onPressed: login, child: const Text('Login')),

                const SizedBox(height: 15),

                // or continue with (sign in option)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      // ignore: prefer_const_constructors
                      Expanded(
                        child: const Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),

                      // ignore: prefer_const_constructors
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: const Text('Or continue with',
                            style: TextStyle(color: Colors.grey)),
                      ),

                      const Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // google sign in
                Row(
                  children: [

                    //google button
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),

                        child: Image.asset(
                        "lib/images/google.png",
                        height: 40,
                        ),
                      
                    ),
                      


                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
