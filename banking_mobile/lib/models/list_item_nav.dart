import 'package:banking_mobile/pages/bill.dart';
import 'package:flutter/material.dart';

class ListItemNav {
  const ListItemNav({
    required this.icon,
    required this.name,
    required this.path
  });

  final Icon icon;
  final String name;
  final Widget path;

  static List<ListItemNav> listItems = [
    ListItemNav(
        icon: Icon(
          Icons.receipt,
          size: 48.0,
          color: Colors.grey,
        ),
        name: "Upiši račun",
        path: Bill()
    )
  ];
}

