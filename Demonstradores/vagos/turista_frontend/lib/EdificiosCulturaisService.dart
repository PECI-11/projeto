import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'AppBar_Monumentos.dart';


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

      body: Column(
        children: [

          CustomAppBarMonumentos(),

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

                      return Card(
                        margin: EdgeInsets.all(10),
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.blueAccent,
                            ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        shadowColor: Colors.blueGrey,
                        child: Column(
                          children: [
                                ListTile(
                                title: Text(monumento['name'],
                                  style: TextStyle(
                                      fontFamily: 'Romelio',
                                      fontSize: 18
                                  ),
                                ),
                                subtitle: Text(monumento['story'],
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                trailing: Icon(Icons.arrow_forward),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetalhesServicoWidget(service: monumento),
                                    ),
                                  );
                                },
                              ),

                        ],
                        ),
                      );


                      /*
                      return ListTile(
                        title: Text(monumento['name'],
                          style: TextStyle(
                              fontFamily: 'Romelio',
                              fontSize: 18
                          ),
                        ),
                        subtitle: Text(monumento['story'],
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
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
                      
                       */
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
              service['story'],
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Estilo do monumento: ${service['style']}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Acessibilidade:  ${service['accessability']}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Horário: ${service['schedule']}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Preço: ${service['price']}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Atividade: ${service['activity']}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Visita Guiada? ${service['guide_visit']}',
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
            SizedBox(height: 8.0),
            Text(
              'Entre em contacto através do email: ${service['user_email']}',
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
    print(response.body);
    final decodedData = json.decode(response.body);
    // print(decodedData);
    final List<Map<String, dynamic>> alojamentos = List<Map<String, dynamic>>.from(decodedData['district_services']);
    //print(alojamentos);
    return alojamentos;
  } else {
    throw Exception('Failed to load data');
  }
}
