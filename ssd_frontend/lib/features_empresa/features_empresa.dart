import 'package:flutter/material.dart';
import 'package:ssd_frontend/servicos/servicos.dart';

class FeaturesEmpresa extends StatefulWidget {
  const FeaturesEmpresa({Key? key}) : super(key: key);

  @override
  _FeaturesEmpresaState createState() => _FeaturesEmpresaState();
}

class _FeaturesEmpresaState extends State<FeaturesEmpresa> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: const Text(
          "Área da Empresa",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white
          ),
        ),
      ),

      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                      child: Image(image: AssetImage("assets/icons/icon_app.png"),
                      ),
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.dataset_rounded
                    ),
                    title: const Text(
                      "Serviços Disponíveis",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ServicosDisponiveis())
                      );
                    },
                  ),

                ],
              ),
            ),

            Container(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  child: Column(
                    children: [
                      Divider(),
                      ListTile(
                        leading: const Icon(
                          Icons.logout,
                        ),
                        title: const Text(
                          "Terminar Sessão",
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}

