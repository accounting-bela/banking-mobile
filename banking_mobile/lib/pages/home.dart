import 'package:banking_mobile/models/list_item_nav.dart';
import 'package:banking_mobile/widgets/row_widget.dart';
import 'package:flutter/material.dart';

import 'bill.dart';

class Home extends StatelessWidget {

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Izbornik"),
      ),
      body: ListView.builder(
          itemCount: ListItemNav.listItems.length,
          itemBuilder: (BuildContext context, int index) {
            return RowWidget(listItem: ListItemNav.listItems[index]);
          }
      )
    );
  }
}
