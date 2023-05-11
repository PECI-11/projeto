import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'monumentos_details.dart';
import 'package:http/http.dart' as http;

class CardMonumentos extends StatefulWidget {
  const CardMonumentos({Key? key}) : super(key: key);

  @override
  State<CardMonumentos> createState() => _CardMonumentosState();
}

class _CardMonumentosState extends State<CardMonumentos> {

  Future<MonumentosDetails> buscarDados() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/user_info/?email=$email'));
    if (response.statusCode == 200) {
      return MonumentosDetails.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Falha ao buscar info de Alojamentos");
    }
  }

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