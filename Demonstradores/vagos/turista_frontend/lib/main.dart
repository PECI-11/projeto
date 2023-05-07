import 'package:flutter/material.dart';
import 'EdificiosCulturaisService.dart';
import 'AlojamentoService.dart';
import 'RestauracaoService.dart';

void main() {
  runApp(MaterialApp(
    home: MainScreen(),
    debugShowCheckedModeBanner: false,
    routes: {
      '/restauracao': (context) => RestauracaoService(),
      '/alojamento': (context) => AlojamentoService(),
      '/edificiosculturais': (context) => EdificiosCulturaisService(),

    },
  ));
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vagos, Aveiro'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 500,
              height: 250,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RestauracaoService()));
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.restaurant, size: 100),
                    Text('RESTAURAÇÃO', style: TextStyle(fontSize: 30)),
                  ],
                ),
              ),
            ),
            SizedBox(width: 20),
            SizedBox(
              width: 500,
              height: 250,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AlojamentoService()));
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.hotel, size: 100),
                    Text('ALOJAMENTO', style: TextStyle(fontSize: 30)),
                  ],
                ),
              ),
            ),
            SizedBox(width: 20),
            SizedBox(
              width: 500,
              height: 250,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EdificiosCulturaisService()));
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.castle, size: 100),
                    Text('EDIFÍCIOS CULTURAIS', style: TextStyle(fontSize: 30)),
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
