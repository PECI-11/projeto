import 'package:flutter/material.dart';
import 'EdificiosCulturaisService.dart';
import 'AlojamentoService.dart';
import 'RestauracaoService.dart';

void main() {
  runApp(MaterialApp(
    home: MainScreen(),
    debugShowCheckedModeBanner: false,
    routes: {
      '/restauracao': (context) => RestauracaoService('Vagos' , 'Restauracao'),
      '/alojamento': (context) => AlojamentoService('Vagos' , 'Alojamento'),
      '/edificiosculturais': (context) => EdificiosService('Vagos' , 'Monumento'),

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Descubra o que Vagos tem para lhe oferecer!',
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 250,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RestauracaoService('Vagos' , 'Restauracao')));
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.restaurant, size: 15),
                      Text('RESTAURAÇÃO', style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 250,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AlojamentoService('Vagos' , 'Alojamento')));
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.hotel, size: 15),
                      Text('ALOJAMENTO', style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 250,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EdificiosService('Vagos' , 'Monumento')));
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.castle, size: 15),
                      Text('EDIFÍCIOS CULTURAIS', style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}