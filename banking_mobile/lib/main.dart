import 'package:banking_mobile/pages/home.dart';
import 'package:banking_mobile/services/auth0Service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

Future main() async {
  await dotenv.load(fileName: "assets/env/.env_dev");
  Auth0Service auth0Service = Auth0Service();
  await auth0Service.init();
  await auth0Service.webLogin();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'mBanking',
        theme: ThemeData(
            primarySwatch: Colors.blue
        ),
        home: Home()
    );
  }

}
