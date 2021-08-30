import 'dart:convert';

import 'package:banking_mobile/models/racun.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'auth0Service.dart';
import 'package:http/http.dart' as http;

class RacunService {

  Map<String, String>? _headers;
  String? _url;

  RacunService() {
    _headers = {};
    _url = "";
  }

  Future<void> init() async {
    _url = (await dotenv.env['API_URL'] ?? "") + '/racun';
    String access_token = Auth0Service.access_token ?? "";
    _headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + access_token
    };
  }

  Future<Racun> saveIngoing(Racun racun) async {
    print(racun.toJson());
    var response = await http.post(Uri.parse((this._url ?? "") + '/ingoing'), headers: this._headers, body: racun.toJson());
    return Racun.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
}