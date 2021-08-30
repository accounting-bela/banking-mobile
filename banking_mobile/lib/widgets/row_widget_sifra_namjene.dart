import 'package:banking_mobile/models/sifraNamjene.dart';
import 'package:flutter/material.dart';

class RowWidgetSifraNamjene extends StatelessWidget {
  const RowWidgetSifraNamjene({
    Key? key,
    required this.sifraNamjene
  }) : super(key: key);

  final SifraNamjene sifraNamjene;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(sifraNamjene.sifra ?? ""),
      subtitle: Text('Naziv: ' + (sifraNamjene.naziv ?? "")),
      selected: false,
      onTap: () => {
        Navigator.pop(context, sifraNamjene)
      },
    );
  }
}
