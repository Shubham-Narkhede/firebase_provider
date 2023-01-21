import 'package:firebase_provider/modules/authentication/providers/ProviderAuthentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/ModelAuthentication.dart';
import '../models/ModelResponce.dart';
import '../repository/RepositoryAddUserData.dart';

class ProviderAddData extends ChangeNotifier {
  addDataInDataBase({
    required ModelAuthentication userData,
  }) {
    RepositoryAddUserData.addDataInDataBase(
      userData: userData,
    ).then((value) {
      FocusScope.of(userData.context!).unfocus();
      provider(userData).response = ModelResponse(
          messageCode: 200, responseMessage: "User Register Successfully");
      provider(userData).logOut(userData.firebaseAuth!);
    }).catchError((onError) {
      provider(userData).response = ModelResponse(
          messageCode: 400, responseMessage: onError.code.toString());
    });
    notifyListeners();
  }

  ProviderAuthentication provider(ModelAuthentication userData) {
    return Provider.of<ProviderAuthentication>(userData.context!,
        listen: false);
  }
}
