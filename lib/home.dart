import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer.dart';
// import 'drawer.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: const Text("My Home Page"),
        ),
        body: Container(
          decoration: const BoxDecoration(color: Colors.amber),
          child: const Center(
            child: Text("Welcome to home page",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30)),
          ),
        ));
  }
}
