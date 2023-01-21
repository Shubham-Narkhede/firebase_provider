import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_provider/core/BaseAuth.dart';
import 'package:firebase_provider/modules/authentication/providers/ProviderAddUserData.dart';
import 'package:firebase_provider/modules/authentication/repository/RepositoryAuthentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../helper/HelperErrorMessage.dart';
import '../models/ModelAuthentication.dart';
import '../models/ModelResponce.dart';
import '../models/enum.dart';

class ProviderAuthentication extends ChangeNotifier {
  ModelResponse response = ModelResponse(responseMessage: "", messageCode: 0);

  ViewState _viewState = ViewState.SignIn;

  ModelResponse get getResponse => response;

  ViewState get getViewState => _viewState;

  setViewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  Future<void> registerNewUser({required ModelAuthentication userData}) async {
    await RepositoryAuthentication.registerUser(userData: userData)
        .then((value) {
      Provider.of<ProviderAddData>(userData.context!, listen: false)
          .addDataInDataBase(userData: userData);
    }).catchError((onError) {
      response = errorResponse(onError);
    });

    notifyListeners();
  }

  Future<void> signInUser({
    required ModelAuthentication userData,
  }) async {
    await RepositoryAuthentication.signInUser(userData: userData).then((value) {
      Provider.of<BaseAuth>(userData.context!, listen: false)
          .setAuthState(userData.firebaseAuth!);
      response =
          ModelResponse(messageCode: 200, responseMessage: "Sign In User");
    }).catchError((onError) {
      response = errorResponse(onError);
    });
    notifyListeners();
  }

  void logOut(FirebaseAuth auth) async {
    await auth.signOut();
    response = ModelResponse(messageCode: 0, responseMessage: "Logout");
    setViewState(ViewState.SignIn);
    notifyListeners();
  }

  ModelResponse errorResponse(dynamic onError) {
    return ModelResponse(
        messageCode: 400,
        responseMessage: getMessageFromErrorCode(onError.code));
  }
}
