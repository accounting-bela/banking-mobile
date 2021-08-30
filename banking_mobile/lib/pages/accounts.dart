import 'package:banking_mobile/models/stranka.dart';
import 'package:banking_mobile/services/strankaService.dart';
import 'package:banking_mobile/widgets/row_widget_stranka.dart';
import 'package:flutter/material.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Odaberi stranku"),
      ),
      body: Center(
        child: FutureBuilder<List<Stranka>>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else
                  return _buildListView(context, snapshot.data ?? []);
            }
          },
        ),
      ),
    );
  }

  Future<List<Stranka>> getData() async {
    StrankaService strankaService = StrankaService();
    await strankaService.init();
    return strankaService.getForKorisnik();
  }

  Widget _buildListView(BuildContext context, List<Stranka> stranke) {
    return ListView.builder(
        itemCount: stranke.length,
        itemBuilder: (BuildContext context, int index) {
          return RowWidgetStranka(stranka: stranke[index]);
        }
    );
  }
}


