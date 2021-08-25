import 'dart:convert';
import 'grad.dart';

class Adresa {
  String? _id;
  String _adresa;
  Grad _grad;

  Adresa(this._adresa, this._grad) {
    this._id = "";
  }

  Adresa.fromJson(Map<String, dynamic> json)
    : _id = json['id'],
      _adresa = json['adresa'],
      _grad = Grad.fromJson(jsonDecode(json['grad']));

  String toJson() {
    Map<String, dynamic> json = {
      'id': _id,
      'adresa': _adresa,
      'grad': jsonDecode(_grad.toJson())
    };
    return jsonEncode(json);
  }

}