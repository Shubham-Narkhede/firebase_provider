import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/ModelAuthentication.dart';

class RepositoryAddUserData {
  static Future<DocumentReference<Map<String, dynamic>>> addDataInDataBase({
    required ModelAuthentication userData,
  }) async {
    return await FirebaseFirestore.instance.collection('userData').add({
      'id': userData.firebaseAuth!.currentUser!.uid,
      "Name": userData.userName,
      "Email": userData.userEmail,
      "Password": userData.userPassword
    });
  }
}
