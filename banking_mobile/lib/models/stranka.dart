import 'dart:convert';
import 'adresa.dart';


class Stranka {
  String? _id;
  String _naziv;
  String _iban;
  String _korisnikId;
  Adresa _adresa;

  Stranka(this._naziv, this._iban, this._korisnikId, this._adresa){
    this._id = "";
  }

  Stranka.fromJson(Map<String, dynamic> json)
    : _id = json['id'],
      _naziv = json['naziv'],
      _iban = json['iban'],
      _korisnikId = json['korisnikId'],
      _adresa = Adresa.fromJson(jsonDecode(json['adresa']));

  String toJson() {
    Map<String, dynamic> json = {
      'id': _id,
      'naziv': _naziv,
      'iban': _iban,
      'korisnikId': _korisnikId,
      'adresa': jsonDecode(_adresa.toJson())
    };
    return jsonEncode(json);
  }

}