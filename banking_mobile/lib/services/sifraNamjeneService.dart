import 'dart:convert';

import 'package:banking_mobile/models/sifraNamjene.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'auth0Service.dart';
import 'package:http/http.dart' as http;

class SifraNamjeneService {

  Map<String, String>? _headers;
  String? _url;

  SifraNamjeneService() {
    _headers = {};
    _url = "";
  }

  Future<void> init() async {
    _url = (await dotenv.env['API_URL'] ?? "") + '/sifra';
    String access_token = Auth0Service.access_token ?? "";
    _headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + access_token
    };
  }

  Future<List<SifraNamjene>> getAll() async {
    var response = await http.get(Uri.parse(this._url ?? ""), headers: this._headers);
    Iterable list = jsonDecode(utf8.decode(response.bodyBytes));
    return list.map((m) => SifraNamjene.fromJson(m)).toList();
  }

}