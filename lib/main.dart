import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:olx/view/dashboard.dart';
import 'package:olx/view/initialsViews/cadastrar.dart';
import 'package:olx/view/initialsViews/login.dart';

void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: dash()
  ));
}