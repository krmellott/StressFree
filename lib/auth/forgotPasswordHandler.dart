import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/auth/signInHandler.dart';
import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../utils/buttons.dart';

class forgotPassword extends StatefulWidget {
  const forgotPassword({Key? key}) : super(key: key);

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  String UserEmail = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Forgot Password"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            _createTextField(),
            _createSendRequestButton(context),
          ],
        ));
  }

  _createTextField() {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Please enter your email!',
          ),
          onChanged: (String? email) {
            setState(() {
              UserEmail = email!;
            });
          },
        ));
  }

  _createSendRequestButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: MyButton(
            label: 'Send email!',
            onTap: () {
              _OnRequest(context);
            }));
  }

  _OnRequest(BuildContext context) async {
    try {
      final user =
          await FirebaseAuth.instance.sendPasswordResetEmail(email: UserEmail);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('AlertDialog Title'),
                  content: const Text('AlertDialog description'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ));
        print('No user found for that email.');
      }
    } finally {
      Navigator.of(context).pop();
    }
  }
}
