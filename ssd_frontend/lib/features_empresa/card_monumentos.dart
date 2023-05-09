import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardMonumentos extends StatefulWidget {
  const CardMonumentos({Key? key}) : super(key: key);

  @override
  State<CardMonumentos> createState() => _CardMonumentosState();
}

class _CardMonumentosState extends State<CardMonumentos> {


  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.castle_rounded),
            title: const Text('Olá'),
            subtitle: Text('Adeus',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('VER MAIS'),
              ),
            ],
          ),
          // COLOCAR IMAGENS
        ],
      ),
    );
  }
}