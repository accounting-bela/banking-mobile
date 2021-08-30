import 'dart:convert';
import 'package:banking_mobile/main.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_auth0/flutter_auth0.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Auth0Service {

  String? _domain;
  String? _clientId;
  String? _redirectURI;
  String? _issues;
  Auth0? _auth;

  static String? access_token;

  bool? webLogged;
  dynamic currentWebAuth;

  Auth0Service() {
    _domain = "";
    _clientId = "";
    _redirectURI = "";
    _issues = "";
    _auth = null as Auth0;
    webLogged = false;
    currentWebAuth = {};
    access_token = "";
  }

  Future<void> init() async {
    _domain = await dotenv.env['AUTH0_DOMAIN'];
    _clientId = await dotenv.env['AUTH0_CLIENT_ID'];
    _redirectURI = await dotenv.env['AUTH0_REDIRECT_URI'];
    _issues = await dotenv.env['AUTH0_ISSUES'];
    _auth = Auth0(baseUrl: this._issues, clientId: this._clientId);
  }

  Map<String, dynamic> parsedIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(
      utf8.decode(base64Url.decode(base64Url.normalize(parts[1])))
    );
  }

  Future<Map> getUserDetails(String accessToken) async {
    final url = 'https://$_domain/userinfo';
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $accessToken'}
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user details');
    }
  }

  Future<void> webLogin() async {
    try {
      var response = await _auth!.webAuth.authorize({
        'audience': 'https://banking/api',
        'scope': 'access:api',
      });
      DateTime now = DateTime.now();
      webLogged = true;
      currentWebAuth = Map.from(response);
      access_token = currentWebAuth['access_token'];
    } catch (e) {
      print('Error: $e');
    }
  }

  void webRefreshToken() async {
    try {
      var response = await _auth!.webAuth.client.refreshToken({
        'refreshToken': currentWebAuth['refresh_token'],
      });
      DateTime now = DateTime.now();
    } catch (e) {
      print('Error: $e');
    }
  }

  void closeSessions() async {
    try {
      await _auth!.webAuth.clearSession();
      webLogged = false;
    } catch (e) {
      print('Error: $e');
    }
  }

}