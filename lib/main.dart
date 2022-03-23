import 'dart:core';
import 'dart:ffi';

import 'package:firstapp/pages/activities_page.dart';
import 'package:firstapp/pages/home_page.dart';
import 'package:firstapp/pages/mood_page.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Home());
}