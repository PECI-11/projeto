import 'package:flutter/material.dart';
import 'package:ssd_frontend/servicos/cartao_servico.dart';
import '../componentes/section_title.dart';
import '../features_empresa/features_empresa.dart';
import '../main.dart';
import '../modelos/exemplos_servicos.dart';
import '../noticias/feature_noticias.dart';

class ServicosDisponiveis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          title: const Text(
            "Serviços Disponíveis",
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
                            Icons.home
                        ),
                        title: const Text(
                          "Voltar para a Página Principal",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Destinos())
                          );
                        },
                      ),

                      ListTile(
                        leading: const Icon(
                            Icons.home
                        ),
                        title: const Text(
                          "Área da Empresa",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => FeaturesEmpresa())
                          );
                        },
                      ),

                      ListTile(
                        leading: const Icon(
                            Icons.home
                        ),
                        title: const Text(
                          "Notícias",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => FeatureNoticias())
                          );
                        },
                      ),

                    ],
                  ),
              ),
            ],
          ),

        ),



        body: Container(
          constraints: BoxConstraints(maxWidth: 2000),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: servicos.length,
                    itemBuilder: (context, index) {
                      return Expanded(
                        child: CartaoServicos(
                          index: index,
                          key: ValueKey(index),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}