import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssd_frontend/features_empresa/restaurantes_details.dart';
import 'package:http/http.dart' as http;

class CardRestaurantes extends StatefulWidget {
  const CardRestaurantes({Key? key}) : super(key: key);

  @override
  State<CardRestaurantes> createState() => _CardRestaurantesState();
}

class _CardRestaurantesState extends State<CardRestaurantes> {

  Future<RestaurantesDetails> buscarDados() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/user_info/?email=$email'));
    if (response.statusCode == 200) {
      return RestaurantesDetails.fromJson(jsonDecode(response.body));
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