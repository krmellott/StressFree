import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/utils/buttons.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final firestoreInstance = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  String _UserEmail = "";
  String _UserPass = "";
  String _UserPassVerification = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up!"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            _createTextFields(),
            _createSignUpButton(context),
          ],
        ));
  }

  _createTextFields() {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Please enter your email!',
              ),
              onChanged: (String? email) {
                setState(() {
                  _UserEmail = email!;
                });
              },
            )),
        Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'New Password',
              ),
              onChanged: (String? password) {
                setState(() {
                  _UserPass = password!;
                });
              },
            )),
        Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Retype Password',
              ),
              onChanged: (String? password) {
                setState(() {
                  _UserPassVerification = password!;
                });
              },
            ))
      ],
    );
  }

  _createSignUpButton(BuildContext context) {
    return MyButton(
        label: "Sign Up!",
        onTap: () {
          _SignUpAction(context);
        });
  }

  _SignUpAction(BuildContext context) async {
    if (_isValidForm()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _UserEmail, password: _UserPass);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      } finally {
        Navigator.pop(context);
      }
    } else {
      print("Passwords don't match!");
      print(_UserEmail + " " + _UserPass + " " + _UserPassVerification);
    }
  }

  bool _isValidForm() {
    return (!((_UserEmail == "") &&
            (_UserPass == "") &&
            (_UserPassVerification == "")) &&
        (_UserPass == _UserPassVerification));
  }
}
