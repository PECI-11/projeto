import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class EdificiosService extends StatefulWidget{
  final String regiao;
  final String tipo;

  EdificiosService(this.regiao , this.tipo);

  @override
  _EdificiosServiceState createState() => _EdificiosServiceState();

}

class _EdificiosServiceState extends State<EdificiosService>{
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
        title: Text('Edifícios Culturais em Vagos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List monumentos = snapshot.data!;
                  return ListView.builder(
                    itemCount: monumentos.length,
                    itemBuilder: (context, index) {
                      final monumento = monumentos[index];
                      return ListTile(
                        title: Text(monumento['name']),
                        subtitle: Text(monumento['story']),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalhesServicoWidget(service: monumento),
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

// !!!!!!!! FALTA TROCAR PARA OS DADOS DOS MONUMENTOS
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
              'Tipo de quarto: ${service['bedroom_type']}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Preço do quarto: ${service['bedroom_prices']}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Serviços disponíveis: ${service['services']}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Localização: ${service['latitude']}, ${service['longitude']}',
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
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: service['images'].length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                final image = service['images'][index];
                final description = service['image_descriptions'][index];
                return Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.0),
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
