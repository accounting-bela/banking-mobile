import 'package:banking_mobile/models/list_item.dart';
import 'package:flutter/material.dart';

class RowWidget extends StatelessWidget {
  const RowWidget({
    Key? key,
    required this.listItem,
  }) : super(key: key);

  final ListItem listItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: listItem.icon,
      title: Text(listItem.name),
      selected: false,
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => listItem.path
            )
        )
      },
    );
  }
}
