import 'dart:core';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firstapp/pages/userSignIn_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  String? token = await FirebaseMessaging.instance.getToken();
  print(token);

  runApp(UserAuth());
}
