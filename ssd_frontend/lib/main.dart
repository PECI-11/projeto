import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

                  ),
                ),
            ),
          ],
        ),
      ),

    );
  }
}
