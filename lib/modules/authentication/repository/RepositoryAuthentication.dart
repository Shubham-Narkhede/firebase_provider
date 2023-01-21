import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_provider/modules/authentication/models/ModelAuthentication.dart';

class RepositoryAuthentication {
  static Future<UserCredential> registerUser(
      {required ModelAuthentication userData}) async {
    return await userData.firebaseAuth!.createUserWithEmailAndPassword(
        email: userData.userEmail!, password: userData.userPassword!);
  }

  static Future<UserCredential> signInUser({
    required ModelAuthentication userData,
  }) async {
    return await userData.firebaseAuth!.signInWithEmailAndPassword(
        email: userData.userEmail!, password: userData.userPassword!);
  }
}
