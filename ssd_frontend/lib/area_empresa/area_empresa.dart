import 'package:flutter/material.dart';
import 'package:ssd_frontend/login/logout.dart';

class AreaEmpresa extends StatefulWidget {
  const AreaEmpresa({Key? key}) : super(key: key);

  @override
  _AreaEmpresaState createState() => _AreaEmpresaState();
}

class _AreaEmpresaState extends State<AreaEmpresa> {

  @override
  Widget build (BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.cyanAccent,
        foregroundColor: const Color.fromRGBO(224, 231, 88, 1.0),
        title: const Text(
          "Área da Empresa",
          style: TextStyle(
              fontSize: 20,
              color: Colors.black38,
          ),
        ),
      ),


      // DRAWER SIDE BAR MENU ----------------------------------------------------
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [

                    // PERFIL
                    ListTile(
                      leading: const Icon(
                        Icons.account_box
                      ),
                      title: const Text(
                        "Perfil",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {

                      },
                    ),

                    // ANUNCIOS DAS OFERTAS
                    ListTile(
                      leading: const Icon(
                        Icons.auto_awesome_mosaic
                      ),
                      title: const Text(
                        "Anúncios das Ofertas",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {

                      },
                    ),

                    // NOTICIAS
                    ListTile(
                      leading: const Icon(
                        Icons.article
                      ),
                      title: const Text(
                        "Notícias",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {

                      },
                    ),

                    // SERVIÇOS DISPONIVEIS
                    ListTile(
                      leading: const Icon(
                        Icons.book
                      ),
                      title: const Text(
                        "Serviços Disponíveis",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {

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
                            Icons.logout
                        ),
                        title: const Text("Terminar sessão",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Logout())
                          );
                        },
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