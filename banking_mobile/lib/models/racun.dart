import 'dart:convert';
import 'package:banking_mobile/models/sifraNamjene.dart';
import 'package:banking_mobile/models/stranka.dart';
import 'package:banking_mobile/utils/enumUtils.dart';
import 'enums/model.dart';



class Racun {
  String? _id;
  String _uplatnica;
  String _valuta;
  int _iznos;
  String _iban;
  Model _model;
  String _pozivNaBroj;
  String _opis;
  SifraNamjene _sifraNamjene;
  Stranka _uplatitelj;
  Stranka _primatelj;

  Racun(this._uplatnica, this._valuta, this._iznos, this._iban, this._model,
      this._pozivNaBroj, this._opis, this._sifraNamjene, this._uplatitelj, this._primatelj) {
    this._id = "";
  }

  Racun.fromJson(Map<String, dynamic> json)
    : _id = json['id'],
      _uplatnica = json['uplatnica'],
      _valuta = json['valuta'],
      _iznos = json['iznos'],
      _iban = json['iban'],
      _model = enumFromString(Model.values, json['model']),
      _pozivNaBroj = json['pozivNaBroj'],
      _opis = json['opis'],
      _sifraNamjene = SifraNamjene.fromJson(jsonDecode(json['sifraNamjene'])),
      _uplatitelj = Stranka.fromJson(jsonDecode(json['uplatitelj'])),
      _primatelj = Stranka.fromJson(jsonDecode(json['primatelj']));

  String toJson() {
    Map<String, dynamic> json = {
      'id': _id,
      'uplatnica': _uplatnica,
      'valuta': _valuta,
      'iznos': _iznos,
      'iban': _iban,
      'model': _model.toString(),
      'pozivNaBroj': _pozivNaBroj,
      'opis': _opis,
      'sifraNamjene': jsonDecode(_sifraNamjene.toJson()),
      'uplatitelj': jsonDecode(_uplatitelj.toJson()),
      'primatelj': jsonDecode(_primatelj.toJson())
    };
    return jsonEncode(json);
  }

}