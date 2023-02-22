import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssd_frontend/area_empresa/area.dart';
import 'package:ssd_frontend/login/login_turista.dart';
import 'package:ssd_frontend/registo_empresas/registo.dart';
import 'package:ssd_frontend/servicos/servicos.dart';

void main() {
  //runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(Destinos());
}

class Destinos extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema de Gestão de Destinos',
      initialRoute: '/',
      routes: {
        "/": (context) => MainPage(),
      },
      themeMode: ThemeMode.dark,
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key ? key}) : super (key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build (BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.cyan,
        shadowColor: Colors.transparent,
        title: const Text(
          "Sistema de Gestão de Destinos",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),

      // BODY -------------------------------------------------------------------
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Wrap(
                    runSpacing: (height+200)*0.02,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: width*0.80,
                            height: height*0.1,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => ServicosDisponiveis())
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.black,
                                  elevation: 15,
                                  backgroundColor: const Color.fromARGB(230, 152, 0, 1),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Text('Serviços Disponíveis',
                                      style: TextStyle(
                                          fontSize: Checkbox.width,
                                          color: Colors.white
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ],
                      ),

                      /*
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: width*0.80,
                            height: height*0.1,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => RegistoEmpresaPage())
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.black,
                                  elevation: 15,
                                  backgroundColor: const Color.fromARGB(230, 152, 0, 1),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Text('Registar Empresa',
                                      style: TextStyle(
                                          fontSize: Checkbox.width,
                                          color: Colors.white
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ],
                      ),*/

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: width*0.80,
                            height: height*0.1,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => const LoginTurista())
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.black,
                                  elevation: 15,
                                  backgroundColor: const Color.fromARGB(230, 152, 0, 1),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Text('Login Turista',
                                      style: TextStyle(
                                          fontSize: Checkbox.width,
                                          color: Colors.white
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: width*0.80,
                            height: height*0.1,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => const AreaEmpresa())
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.black,
                                  elevation: 15,
                                  backgroundColor: const Color.fromARGB(230, 152, 0, 1),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Text('Área da Empresa',
                                      style: TextStyle(
                                          fontSize: Checkbox.width,
                                          color: Colors.white
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),
                ),
            ),
          ],
        ),
      ),

    );
  }
}
