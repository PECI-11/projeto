import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ssd_frontend/main.dart';
import 'package:ssd_frontend/noticias/feature_noticias.dart';
import 'package:ssd_frontend/servicos/servicos.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FeaturesEmpresa extends StatefulWidget {
  const FeaturesEmpresa({Key? key}) : super(key: key);

  @override
  _FeaturesEmpresaState createState() => _FeaturesEmpresaState();
}

class _FeaturesEmpresaState extends State<FeaturesEmpresa> {

  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = auth.currentUser;
  }

  String userEmail = "";
  String userPhoneNumber = "";



  @override
  Widget build(BuildContext context) {
    if (currentUser != null) {
      userEmail = currentUser!.email ?? "";
      userPhoneNumber = currentUser!.phoneNumber ?? "";
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
                      "Alertas",          // CRIAR
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

                  ListTile(
                    leading: const Icon(
                      Icons.dataset_rounded
                    ),
                    title: const Text(
                      "Criação de Anúncios",      // CRIAR
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

            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                child: Column(
                  children: const [
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.logout,
                      ),
                      title: Text(
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
          ],
        ),
      ),

      body: Column(
        children: [
          const Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Restaurante 5 maravilhas",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),

                  SizedBox(height: 16,),

                  Text(
                    //"5maravilhas@gmail.com",
                    userEmail,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  SizedBox(height: 10,),

                  Text(
                    "232854123",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  SizedBox(height: 16,),

                  _ProfileInfoRow()

                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({Key? key}) : super(key: key);

  final List<ProfileInfoItem> _items = const [
    ProfileInfoItem("Anúncios", 5),
    ProfileInfoItem("Visitantes", 40),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items
            .map((item) => Expanded(
            child: Row(
              children: [
                if (_items.indexOf(item) != 0) const VerticalDivider(),
                Expanded(child: _singleItem(context, item)),
              ],
            )))
            .toList(),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item.value.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      Text(
        item.title,
        style: Theme.of(context).textTheme.caption,
      )
    ],
  );

}



class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}



class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.blueAccent, Colors.blue]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/json_profiles/profile1.png")
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}

