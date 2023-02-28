import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Sign Out'),
            onTap: () {
              // update the state of the app - sign out
              FirebaseAuth.instance.signOut();
              // then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
