import 'dart:convert';
import 'adresa.dart';


class Stranka {
  String? _id;
  String? _naziv;
  String? _iban;
  String? _korisnikId;
  Adresa? _adresa;

  Stranka.empty() {
    _adresa = Adresa.empty();
  }

  Stranka(this._naziv, this._iban, this._korisnikId, this._adresa){
    this._id = "";
  }

  Stranka.fromJson(Map<String, dynamic> json)
    : _id = json['id'],
      _naziv = json['naziv'],
      _iban = json['iban'],
      _korisnikId = json['korisnikId'],
      _adresa = Adresa.fromJson(json['adresa']);

  String toJson() {
    Map<String, dynamic> json = {
      'id': _id,
      'naziv': _naziv,
      'iban': _iban,
      'korisnikId': _korisnikId,
      'adresa': jsonDecode(_adresa!.toJson())
    };
    return jsonEncode(json);
  }

  String? get id => _id;

  String? get naziv => _naziv;

  String? get iban => _iban;

  String? get korisnikId => _korisnikId;

  Adresa? get adresa => _adresa;

  set id(String? value) {
    _id = value;
  }

  set naziv(String? value) {
    _naziv = value;
  }

  set iban(String? value) {
    _iban = value;
  }

  set korisnikId(String? value) {
    _korisnikId = value;
  }

  set adresa(Adresa? value) {
    _adresa = value;
  }
}