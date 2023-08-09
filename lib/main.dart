import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure Firebase
  final firebaseConfig = const FirebaseOptions(
    apiKey: "AIzaSyDaM-cmoBm1pTSIuBc552XAFO7zzH5vtWQ",
    authDomain: "superior-school-4287a.firebaseapp.com",
    databaseURL: "https://superior-school-4287a-default-rtdb.asia-southeast1.firebasedatabase.app",
    projectId: "superior-school-4287a",
    storageBucket: "superior-school-4287a.appspot.com",
    messagingSenderId: "987492696053",
    appId: "1:987492696053:web:89919abe9f4957cffe6abc",
    measurementId: "G-QZ50WM4JHY",
  );

  await Firebase.initializeApp(options: firebaseConfig);

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Tabs',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
    );
  }
}

