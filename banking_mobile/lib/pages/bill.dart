import 'dart:convert';

import 'package:banking_mobile/models/adresa.dart';
import 'package:banking_mobile/models/enums/model.dart';
import 'package:banking_mobile/models/grad.dart';
import 'package:banking_mobile/models/racun.dart';
import 'package:banking_mobile/models/sifraNamjene.dart';
import 'package:banking_mobile/models/stranka.dart';
import 'package:banking_mobile/pages/codes.dart';
import 'package:banking_mobile/pages/qr_scan.dart';
import 'package:banking_mobile/services/racunService.dart';
import 'package:banking_mobile/services/sifraNamjeneService.dart';
import 'package:banking_mobile/services/strankaService.dart';
import 'package:banking_mobile/utils/enumUtils.dart';
import 'package:flutter/material.dart';

import 'accounts.dart';

class Bill extends StatefulWidget {
  const Bill({Key? key}) : super(key: key);

  @override
  _BillState createState() => _BillState();
}

class _BillState extends State<Bill> {

  Racun _racun = Racun.empty();
  Stranka _primatelj = Stranka.empty();
  Stranka _uplatitelj = Stranka.empty();
  Adresa _adresa = Adresa.empty();
  Grad _grad = Grad.empty();
  SifraNamjene _sifraNamjene = SifraNamjene.empty();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _valutaController = TextEditingController();
  TextEditingController _iznosController = TextEditingController();
  TextEditingController _nazivController = TextEditingController();
  TextEditingController _ibanController = TextEditingController();
  TextEditingController _adresaController = TextEditingController();
  TextEditingController _gradController = TextEditingController();
  TextEditingController _postController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _pozivController = TextEditingController();
  TextEditingController _opisController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upis računa"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(15.0),
                child: Material(
                  elevation: 20,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: _uplatitelj.id == null ? buildButton() : buildDetails(),
                  ),
                )
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: ElevatedButton(
                    onPressed: () {getQR();},
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.qr_code),
                            Text("Skeniraj QR")
                          ],
                        )
                    )
                )
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              var validation = null;
                              validation = checkIfEmpty(value!);
                              if(validation != null)
                              {
                                return validation;
                              }
                              return null;
                            },
                            controller: _valutaController,
                            decoration: InputDecoration(
                                hintText: 'Valuta'
                            ),
                            onSaved: (value) {
                              _racun.valuta = value!;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.numberWithOptions(),
                            validator: (value) {
                              var validation = null;
                              validation = checkIfEmpty(value!);
                              if(validation != null)
                              {
                                return validation;
                              }
                              validation = checkIfNumeric(value);
                              if(validation != null)
                              {
                                return validation;
                              }
                              return validation;
                            },
                            controller: _iznosController,
                            decoration: InputDecoration(
                                hintText: 'Iznos'
                            ),
                            onSaved: (value) {
                              _racun.iznos = (double.parse(value!) * 100).round();
                            },
                          ),
                          TextFormField(
                            validator: (value) {
                              var validation = null;
                              validation = checkIfEmpty(value!);
                              if(validation != null)
                              {
                                return validation;
                              }
                              return validation;
                            },
                            controller: _nazivController,
                            decoration: InputDecoration(
                                hintText: 'Naziv uplatitelja'
                            ),
                            onSaved: (value) {
                              _primatelj.naziv = value!;
                            },
                          ),
                          TextFormField(
                            validator: (value) {
                              var validation = null;
                              validation = checkIfEmpty(value!);
                              if(validation != null)
                              {
                                return validation;
                              }
                              return validation;
                            },
                            controller: _ibanController,
                            decoration: InputDecoration(
                                hintText: 'IBAN'
                            ),
                            onSaved: (value) {
                              _primatelj.iban = value;
                              _racun.iban = value!;
                            },
                          ),
                          TextFormField(
                            validator: (value) {
                              var validation = null;
                              validation = checkIfEmpty(value!);
                              if(validation != null)
                              {
                                return validation;
                              }
                              return validation;
                            },
                            controller: _adresaController,
                            decoration: InputDecoration(
                                hintText: 'Adresa uplatitelja'
                            ),
                            onSaved: (value) {
                              _adresa.adresa = value!;
                            },
                          ),
                          TextFormField(
                            validator: (value) {
                              var validation = null;
                              validation = checkIfEmpty(value!);
                              if(validation != null)
                              {
                                return validation;
                              }
                              return validation;
                            },
                            controller: _gradController,
                            decoration: InputDecoration(
                                hintText: 'Grad uplatitelja'
                            ),
                            onSaved: (value) {
                              _grad.naziv = value!;
                            },
                          ),
                          TextFormField(
                              keyboardType: TextInputType.number,
                            validator: (value) {
                              var validation = null;
                              validation = checkIfEmpty(value!);
                              if(validation != null)
                              {
                                return validation;
                              }
                              validation = checkIfNumeric(value!);
                              if(validation != null)
                              {
                                return validation;
                              }
                              return validation;
                            },
                            controller: _postController,
                            decoration: InputDecoration(
                                hintText: 'Poštanski broj'
                            ),
                            onSaved: (value) {
                              _grad.post = value!;
                            },
                          ),
                          TextFormField(
                            validator: (value) {
                              var validation = null;
                              validation = checkIfEmpty(value!);
                              if(validation != null)
                              {
                                return validation;
                              }
                              validation = checkIfModel(value!);
                              if(validation != null)
                              {
                                return validation;
                              }
                              return validation;
                            },
                            controller: _modelController,
                            decoration: InputDecoration(
                                hintText: 'Model'
                            ),
                            onSaved: (value) {
                              _racun.model = enumFromString(Model.values, value!);
                            },
                          ),
                          TextFormField(
                            validator: (value) {
                              var validation = null;
                              validation = checkIfEmpty(value!);
                              if(validation != null)
                              {
                                return validation;
                              }
                              return validation;
                            },
                            controller: _pozivController,
                            decoration: InputDecoration(
                                hintText: 'Poziv na broj'
                            ),
                            onSaved: (value) {
                              _racun.pozivNaBroj = value!;
                            },
                          ),
                          TextFormField(
                            validator: (value) {
                              var validation = null;
                              validation = checkIfEmpty(value!);
                              if(validation != null)
                              {
                                return validation;
                              }
                              return validation;
                            },
                            controller: _opisController,
                            decoration: InputDecoration(
                                hintText: 'Opis'
                            ),
                            onSaved: (value) {
                              _racun.opis = value!;
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Center(
                                      child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child:Text(
                                            'Šifra namjene',
                                            style: TextStyle(
                                                fontSize: 17
                                            ),
                                          )
                                      )
                                  )
                              ),
                              Expanded(
                                child: _sifraNamjene.rbr != null ?
                                Center(
                                    child: Padding(
                                        padding: EdgeInsets.all(20),
                                        child:Text(
                                          _sifraNamjene.sifra ?? "",
                                          style: TextStyle(
                                              fontSize: 17
                                          ),
                                        )
                                    )
                                )
                                    : ElevatedButton(
                                    onPressed: () async {
                                      var result =  await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Codes(),
                                              fullscreenDialog: true
                                          )
                                      );
                                      if(result != null)
                                      {
                                        setState(() {
                                          _sifraNamjene = result;
                                        });
                                      }
                                    },
                                    child: Text('Odaberi')
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.redAccent
                              ),
                              child: Text('Očisti'),
                              onPressed: () {
                                setState(() {
                                  _sifraNamjene = SifraNamjene.empty();
                                });
                              },
                            ),
                            visible: _sifraNamjene.rbr != null,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                            child: Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 30)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      'Spremi',
                                      style: TextStyle(
                                          fontSize: 20
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if(_formKey.currentState!.validate())
                                    {
                                      _formKey.currentState!.save();
                                      _racun.uplatitelj = _uplatitelj;
                                      _adresa.grad = _grad;
                                      _primatelj.adresa = _adresa;
                                      _racun.primatelj = _primatelj;
                                      _racun.sifraNamjene = _sifraNamjene;
                                      RacunService racunService = RacunService();
                                      await racunService.init();
                                      print(racunService.saveIngoing(_racun));
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text('Uspješno spremljeno')
                                      ));
                                      Navigator.pop(context);
                                    }
                                  },
                                )
                            ),
                          )

                        ],
                      ),
                    ),
                  ],
                )
            )
          ],
        ),
      )
    );
  }

  buildButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 0),
      child: Center(
        child: ElevatedButton(
          child: Text('Odaberi stranku'),
          onPressed: () {
            changeAccount();
          },
        ),
      ),
    );
  }

  buildDetails() {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('Naziv: ${_uplatitelj.naziv}'),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('IBAN: ${_uplatitelj.iban}'),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ElevatedButton(
              child: Text('Promijeni'),
              onPressed: () {
                changeAccount();
              },
            ),
          )
        ],
      )
    );
  }

  changeAccount() async {
    var result =  await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Accounts(),
            fullscreenDialog: true
        )
    );
    if(result != null)
    {
      setState(() {
        _uplatitelj = result;
      });
    }
  }

  getQR() async {
    var result =  await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Scanner(),
            fullscreenDialog: true
        )
    );
    List<String> results = utf8.decode(result.toString().codeUnits).split('\n');
    _racun.uplatnica = results[0];
    _valutaController.text = results[1];
    _valutaController.selection = TextSelection.fromPosition(
        TextPosition(offset: _valutaController.text.length)
    );
    _iznosController.text = (double.parse(results[2]) / 100).toString();
    _iznosController.selection = TextSelection.fromPosition(
        TextPosition(offset: _iznosController.text.length)
    );
    _nazivController.text = results[6];
    _nazivController.selection = TextSelection.fromPosition(
        TextPosition(offset: _nazivController.text.length)
    );
    _adresaController.text = results[7];
    _adresaController.selection = TextSelection.fromPosition(
        TextPosition(offset: _adresaController.text.length)
    );
    List<String> gradInfo = results[8].split(" ");
    _postController.text = gradInfo.removeAt(0);
    _postController.selection = TextSelection.fromPosition(
        TextPosition(offset: _postController.text.length)
    );
    _gradController.text = gradInfo.join(" ");
    _gradController.selection = TextSelection.fromPosition(
        TextPosition(offset: _gradController.text.length)
    );
    _ibanController.text = results[9];
    _ibanController.selection = TextSelection.fromPosition(
        TextPosition(offset: _ibanController.text.length)
    );
    _modelController.text = results[10];
    _modelController.selection = TextSelection.fromPosition(
        TextPosition(offset: _modelController.text.length)
    );
    _pozivController.text = results[11];
    _pozivController.selection = TextSelection.fromPosition(
        TextPosition(offset: _pozivController.text.length)
    );
    _opisController.text = results[13];
    _opisController.selection = TextSelection.fromPosition(
        TextPosition(offset: _opisController.text.length)
    );
    _sifraNamjene = await getCode(results[12]);
    setState(() {});

  }

  Future<SifraNamjene> getCode(String value) async {
    SifraNamjeneService sifraService = SifraNamjeneService();
    await sifraService.init();
    return (await sifraService.getAll()).singleWhere((element) => element.sifra == value);
  }

  checkIfEmpty(String value) {
    if (value == null || value.isEmpty) {
      return 'Polje ne može bit prazno';
    }
    return null;
  }

  checkIfNumeric(String value) {
    if((double.parse(value) ?? null) == null) {
      return 'Vrijednost mora biti numerička';
    }
    return null;
  }

  checkIfModel(String value) {
    if(enumFromString(Model.values, value) == null) {
      return 'Ne postoji takav model';
    }
    return null;
  }



}
