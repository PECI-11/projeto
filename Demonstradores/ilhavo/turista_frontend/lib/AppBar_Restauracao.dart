import 'package:flutter/material.dart';

import 'IconBack.dart';

class CustomAppBarRestauracao extends StatelessWidget {
  const CustomAppBarRestauracao({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(46),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 30,
            color: Colors.black.withOpacity(0.16),
          ),
        ],
      ),
      child: Row(
        children: [

          /*
          Image.asset(
            "assets/icons/icon_app.png",
            height: 40,
            alignment: Alignment.topCenter,
          ),*/

          IconBack(
              onPressed: () {
                Navigator.pop(context);
              }
          ),

          SizedBox(
            width: 5,
          ),


          Text(
            "Restauração EM ÍLHAVO".toUpperCase(),
            style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: 'Hellishy'
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}