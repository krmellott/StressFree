import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/auth/forgotPasswordHandler.dart';
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
  String _userEmail = "";
  String _userPass = "";

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
                  body: Container(
                      width: 1000,
                      height: 5000,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.lightBlueAccent, Colors.white])),
                      child: SingleChildScrollView(
                          child: Center(
                              child: Column(
                        children: <Widget>[
                          _createSignUpLogo(),
                          _createTextFields(),
                          _createForgotPasswordButton(context),
                          _createSignUpButton(context),
                          _createSendButton(context),
                          //_createAutoSignIn(context)
                        ],
                      )))),
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
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 3.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(221, 75, 75, 75), width: 2.0),
                  ),
                  labelText: 'Please enter your email!',
                  filled: true,
                  fillColor: Colors.white),
              onChanged: (String? email) {
                setState(() {
                  _userEmail = email!;
                });
              },
            )),
        Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: TextField(
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
              obscureText: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 3.0),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(221, 75, 75, 75), width: 2.0)),
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (String? password) {
                setState(() {
                  _userPass = password!;
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
              _onSignIn(context);
            }));
  }

  _createSignUpButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: TextButton(
          child: Text("Don't have an account? Sign up here!"),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return SignIn();
            }));
          },
        ));
  }

  _createForgotPasswordButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: TextButton(
          child: Text("Forgot Password?"),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return ForgotPassword();
            }));
          },
        ));
  }

  // _createAutoSignIn(BuildContext context) {
  //   return Container(
  //       margin: const EdgeInsets.only(top: 20),
  //       child: MyButton(
  //           label: 'dev login',
  //           onTap: () {
  //             _devSignIn(context);
  //           }));
  // }

  _onSignIn(BuildContext context) async {
    try {
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _userEmail, password: _userPass);
      if (user.user!.uid != "") {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return Home();
        }));
      }
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

// _devSignIn(BuildContext context) async {
//   try {
//     final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: 'testuser@live.com', password: 'abc123');
//     if (user.user!.uid != "") {
//       Navigator.of(context)
//           .push(MaterialPageRoute(builder: (BuildContext context) {
//         return Home();
//       }));
//     }
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'user-not-found') {
//       print('No user found for that email.');
//     } else if (e.code == 'wrong-password') {
//       print('Wrong password provided for that user.');
//     }
//   }
// }
}
