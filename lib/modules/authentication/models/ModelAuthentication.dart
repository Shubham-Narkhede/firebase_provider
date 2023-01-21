import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ModelAuthentication {
  String? userEmail;
  String? userPassword;
  String? userName;
  BuildContext? context;
  FirebaseAuth? firebaseAuth;

  ModelAuthentication(
      {this.userName,
      required this.userEmail,
      required this.userPassword,
      required this.context,
      this.firebaseAuth});
}
