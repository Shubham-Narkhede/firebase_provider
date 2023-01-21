import 'package:flutter/foundation.dart';

class ProviderPassword extends ChangeNotifier {
  bool obsecureText = true;

  bool get getObsecureText => obsecureText;

  setObsecureText(bool value) {
    obsecureText = value;
    notifyListeners();
  }
}
