import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/pages/home_page.dart';
import 'package:firstapp/utils/buttons.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/auth/signInHandler.dart';

class UserAuth extends StatefulWidget {
  const UserAuth({Key? key}) : super(key: key);

  @override
  State<UserAuth> createState() => _UserAuthState();
}

class _UserAuthState extends State<UserAuth> {
  String UserEmail = "";
  String UserPass = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green,
        ),
        home: Builder(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text("StressFree!"),
                    centerTitle: true,
                  ),
                  body: Center(
                      child: Column(
                    children: <Widget>[
                      _createSignUpLogo(),
                      _createTextFields(),
                      _createSignUpButton(context),
                      _createSendButton(context),
                    ],
                  )),
                )));
  }

  _createSignUpLogo() {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 100),
        child: Text('Log in', style: TextStyle(fontSize: 32)));
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
                  UserEmail = email!;
                });
              },
            )),
        Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              onChanged: (String? password) {
                setState(() {
                  UserPass = password!;
                });
              },
            ))
      ],
    );
  }

  _createSendButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: MyButton(
            label: 'Log In!',
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return Home();
              }));
              //_OnSignIn(context);
            }));
  }

  _createSignUpButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: TextButton(
          child: Text("Don't have an account? Sign up here!"),
          onPressed: () {
            _OnSignIn(context);
          },
        ));
  }

  _OnSignIn(BuildContext context) async {
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: UserEmail, password: UserPass);
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (BuildContext context) {
      //   return SignIn();
      // }));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } finally {
      //  print(userCredential.user.uid);
    }
  }
}
