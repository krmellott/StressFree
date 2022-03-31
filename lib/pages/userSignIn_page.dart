import 'package:firstapp/pages/home_page.dart';
import 'package:firstapp/utils/buttons.dart';
import 'package:flutter/material.dart';

class UserAuth extends StatefulWidget {
  const UserAuth({Key? key}) : super(key: key);

  @override
  State<UserAuth> createState() => _UserAuthState();
}

class _UserAuthState extends State<UserAuth> {
  String _UserEmail = "";
  String _UserPass = "";

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
                      _createSendButton(context)
                    ],
                  )),
                )));
  }

  _createSignUpLogo() {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 10, top: 100),
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
              onSubmitted: (String? email) {
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
                labelText: 'Password',
              ),
              onSubmitted: (String? password) {
                setState(() {
                  _UserPass = password!;
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
            }));
  }
}
