import 'dart:convert';

import 'package:banking_mobile/models/stranka.dart';
import 'package:banking_mobile/services/auth0Service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class StrankaService {

  Map<String, String>? _headers;
  String? _url;

  StrankaService() {
    _headers = {};
    _url = "";
  }

  Future<void> init() async {
    _url = (await dotenv.env['API_URL'] ?? "") + '/stranka';
    String access_token = Auth0Service.access_token ?? "";
    _headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + access_token
    };
  }

  Future<List<Stranka>> getForKorisnik() async {
    var response = await http.get(Uri.parse((this._url ?? "") + '/korisnik'), headers: this._headers);
    Iterable list = jsonDecode(utf8.decode(response.bodyBytes));
    return list.map((m) => Stranka.fromJson(m)).toList();
  }

}