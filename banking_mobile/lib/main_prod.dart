import 'package:banking_mobile/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: "assets/env/.env_production");
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