import 'dart:convert';

class Grad {
  String? _id;
  String? _naziv;
  String? _post;

  Grad.empty();

  Grad(this._naziv, this._post) {
    this._id = "";
  }

  Grad.fromJson(Map<String, dynamic> json)
    : _id = json['id'],
      _naziv = json['naziv'],
      _post = json['post'];

  String toJson() {
    Map<String, dynamic> json = {
      'id': _id,
      'naziv': _naziv,
      'post': _post
    };
    return jsonEncode(json);
  }

  set post(String value) {
    _post = value;
  }

  set naziv(String value) {
    _naziv = value;
  }

  set id(String value) {
    _id = value;
  }
}