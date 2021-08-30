import 'dart:convert';
import 'grad.dart';

class Adresa {
  String? _id;
  String? _adresa;
  Grad? _grad;

  Adresa.empty() {
    _grad = Grad.empty();
  }

  Adresa(this._adresa, this._grad) {
    this._id = "";
  }

  Adresa.fromJson(Map<String, dynamic> json)
    : _id = json['id'],
      _adresa = json['adresa'],
      _grad = Grad.fromJson(json['grad']);

  String toJson() {
    Map<String, dynamic> json = {
      'id': _id,
      'adresa': _adresa,
      'grad': jsonDecode(_grad!.toJson())
    };
    return jsonEncode(json);
  }

  set id(String value) {
    _id = value;
  }

  set adresa(String value) {
    _adresa = value;
  }

  set grad(Grad value) {
    _grad = value;
  }
}