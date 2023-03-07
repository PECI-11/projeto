import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssd_frontend/modelos/nav_item.dart';
import '../provider/nav_provider.dart';
import 'perfil_empresa.dart';

class AreaEmpresa extends StatelessWidget {
  static final String title = 'Área da Empresa';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => NavigationProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: Empresa(),
    ),
  );
}


class Empresa extends StatefulWidget {
  @override
  _AreaEmpresaState createState() => _AreaEmpresaState();
}

class _AreaEmpresaState extends State<Empresa> {
  @override
  Widget build(BuildContext context) => buildPages();

  buildPages() {
    final provider = Provider.of<NavigationProvider>(context);
    final navigationItem = provider.navigationItem;

    switch (navigationItem) {
      case NavigationItem.perfil:
        return ProfilePageCompany();
    }
  }
}


