import 'package:banking_mobile/models/stranka.dart';
import 'package:flutter/material.dart';

class RowWidgetStranka extends StatelessWidget {
  const RowWidgetStranka({
    Key? key,
    required this.stranka
  }) : super(key: key);

  final Stranka stranka;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stranka.naziv ?? ""),
      subtitle: Text('IBAN: ' + (stranka.iban ?? "")),
      selected: false,
      onTap: () => {
        Navigator.pop(context, stranka)
      },
    );
  }
}
