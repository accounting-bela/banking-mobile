import 'package:banking_mobile/models/sifraNamjene.dart';
import 'package:banking_mobile/services/sifraNamjeneService.dart';
import 'package:banking_mobile/widgets/row_widget_sifra_namjene.dart';
import 'package:flutter/material.dart';

class Codes extends StatefulWidget {
  const Codes({Key? key}) : super(key: key);

  @override
  _CodesState createState() => _CodesState();
}

class _CodesState extends State<Codes> {

  String _searchString = "";

  TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Odaberi šifru namjene"),
      ),
      body: Center(
        child: FutureBuilder<List<SifraNamjene>>(
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
            )
      ),
    );
  }

  Future<List<SifraNamjene>> getData() async {
    SifraNamjeneService sifraService = SifraNamjeneService();
    await sifraService.init();
    return sifraService.getAll();
  }

  Widget _buildListView(BuildContext context, List<SifraNamjene> sifre) {
    return ListView.builder(
        itemCount: sifre.length,
        itemBuilder: (BuildContext context, int index) {
          return RowWidgetSifraNamjene(sifraNamjene: sifre[index]);
        }
    );
  }
}
