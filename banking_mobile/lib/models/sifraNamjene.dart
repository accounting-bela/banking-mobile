import 'dart:convert';

class SifraNamjene {
  int? _rbr;
  String? _klasifikacija;
  String? _sifra;
  String? _naziv;
  String? _definicija;

  SifraNamjene.empty();



  SifraNamjene.fromJson(Map<String, dynamic> json)
    : _rbr = json['rbr'],
      _klasifikacija = json['klasifikacija'],
      _sifra = json['sifra'],
      _naziv = json['naziv'],
      _definicija = json['definicija'];

  String toJson() {
    Map<String, dynamic> json = {
      'rbr': _rbr,
      'klasifikacija': _klasifikacija,
      'sifra': _sifra,
      'naziv': _naziv,
      'definicija': _definicija
    };
    return jsonEncode(json);
  }

  int? get rbr => _rbr;

  String? get klasifikacija => _klasifikacija;

  String? get sifra => _sifra;

  String? get naziv => _naziv;

  String? get definicija => _definicija;
}