import 'package:fk_demo/Auth/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String uid = context.watch<User?>()!.uid.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Demo'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthServices>().signOut();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            'Welcome User \n UID: $uid',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
