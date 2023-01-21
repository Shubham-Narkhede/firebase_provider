import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BaseAuth extends ChangeNotifier {
  FirebaseAuth _authState = FirebaseAuth.instance;

  FirebaseAuth get authState => _authState;

  setAuthState(FirebaseAuth authState) {
    _authState = authState;
    notifyListeners();
  }
}
