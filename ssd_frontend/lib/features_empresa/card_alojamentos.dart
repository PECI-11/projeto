import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardAlojamentos extends StatefulWidget {
  const CardAlojamentos({Key? key}) : super(key: key);

  @override
  State<CardAlojamentos> createState() => _CardAlojamentosState();
}

class _CardAlojamentosState extends State<CardAlojamentos> {

  Future<bool> buscarDados() async {
  final response = await.http.get(Uri.parse('http://127.0.0.1:8000/user_info/?email=$email'));
  if (response.statusCode == 200) {
    return
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