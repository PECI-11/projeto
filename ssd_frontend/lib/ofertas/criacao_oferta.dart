import 'dart:math';

import 'package:flutter/material.dart';

class CriacaoOfertas extends StatefulWidget {
  const CriacaoOfertas({Key? key}) : super(key: key);

  @override
  _CriacaoOfertasState createState() => _CriacaoOfertasState();
}

class _CriacaoOfertasState extends State<CriacaoOfertas> {

  int numberPackage = 0;

  removePackage() {
    setState(() {
      numberPackage--;
      numberPackage = max(numberPackage, 0);
    });
  }

  addPackage() {
    setState(() {
      numberPackage++;
      numberPackage = min(numberPackage, 5);
    });
  }

  @override
  Widget build (BuildContext context) {

    Size size = MediaQuery.of(context).size;
    ThemeData appTheme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        elevation: 0,
        child: Icon(Icons.menu),
      ),

      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: size.height * 0.7,
              color: Colors.grey,
              child: Image(
                image: AssetImage('assets/image/pic1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(top: 26, left: 20, right: 20),
            ),
          ),

        ],
      ),


    );

  }

}
