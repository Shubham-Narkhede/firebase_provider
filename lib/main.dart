import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_provider/modules/authentication/providers/ProviderPassword.dart';
import 'package:firebase_provider/modules/home/screens/ScreenHome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/BaseAuth.dart';
import 'modules/authentication/providers/ProviderAddUserData.dart';
import 'modules/authentication/providers/ProviderAuthentication.dart';
import 'modules/authentication/screens/ScreenAuthentication.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

MaterialColor myGreen = const MaterialColor(0xff0C54BE, {
  50: Color(0xff0C54BE),
  100: Color(0xff0C54BE),
  200: Color(0xff0C54BE),
  300: Color(0xff0C54BE),
  400: Color(0xff0C54BE),
  500: Color(0xff0C54BE),
  600: Color(0xff0C54BE),
  700: Color(0xff0C54BE),
  800: Color(0xff0C54BE),
  900: Color(0xff0C54BE)
});

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BaseAuth(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderAuthentication(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderPassword(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderAddData(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: myGreen,
        ),
        home: Consumer<BaseAuth>(builder: (context, callBack, child) {
          return callBack.authState.currentUser == null
              ? ScreenAuthentication()
              : ScreenHome();
        }),
      ),
    );
  }
}
