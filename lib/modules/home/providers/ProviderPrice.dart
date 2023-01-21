import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class ProviderPrice extends ChangeNotifier {
  bool isDiscountedPrice = true;

  bool get getShowDiscountedPrice => isDiscountedPrice;

  checkDiscountedRate() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.ensureInitialized();

    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(seconds: 0),
    ));

    await remoteConfig.fetchAndActivate();

    isDiscountedPrice = remoteConfig.getBool('showDiscountedPrice');
    notifyListeners();
  }
}
