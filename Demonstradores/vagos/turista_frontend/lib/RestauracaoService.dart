import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class RestauracaoService extends StatefulWidget{
  final String regiao;
  final String tipo;

  RestauracaoService(this.regiao , this.tipo);

  @override
  _RestauracaoServiceState createState() => _RestauracaoServiceState();

}

class _RestauracaoServiceState extends State<RestauracaoService>{
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = fetchData(widget.regiao , widget.tipo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restauração em Vagos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List alojamentos = snapshot.data!;
                  return ListView.builder(
                    itemCount: alojamentos.length,
                    itemBuilder: (context, index) {
                      final alojamento = alojamentos[index];
                      return ListTile(
                        title: Text(alojamento['name']),
                        subtitle: Text(alojamento['description']),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalhesServicoWidget(service: alojamento),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}

// VAI REPRESENTAR OS DETALHES TODOS DO SERVIÇO, OU SEJA OS DADOS TODOS
class DetalhesServicoWidget extends StatelessWidget {
  final Map<String, dynamic> service;

  const DetalhesServicoWidget({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              service['description'],
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Horário: ${service['hours']}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Promoções: ${service['promo']}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Rua: ${service['rua']}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),

            SizedBox(height: 8.0),
            Text(
              'Coordenadas: ${service['latitude']}, ${service['longitude']}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Entre em contacto através do email: ${service['email']}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Imagens:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            SizedBox(height: 8.0),
            GridView.builder(

              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: service['images'] != null ? service['images'].length : 0,

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                final imageData = service['images'][index];
                return Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.memory(
                          base64Decode(imageData),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 8.0),
            GridView.builder(

              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: service['ementa'] != null ? service['ementa'].length : 0,

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                final imageData = service['ementa'][index];
                return Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.memory(
                          base64Decode(imageData),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}




// FUNCAO COM METODO GET PARA IR BUSCAR OS DADOS AO BACKEND
Future<List<Map<String, dynamic>>> fetchData(String regiao , String tipo) async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/services_concelho/$regiao/$tipo/'));

  if (response.statusCode == 200) {

    final decodedData = json.decode(response.body);
    // print(decodedData);
    final List<Map<String, dynamic>> alojamentos = List<Map<String, dynamic>>.from(decodedData['district_services']);
    //print(alojamentos);
    return alojamentos;
  } else {
    throw Exception('Failed to load data');
  }
}



class ImageFromBase64String extends StatelessWidget {
  final String base64String;

  ImageFromBase64String(this.base64String);

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.cover,
    );
  }
}
