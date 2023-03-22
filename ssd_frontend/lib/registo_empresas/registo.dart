import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ...

// // Define a function to get the concelhos for a given district
// Future<List<String>> getConcelhos(String districtId) async {
//  final response = await http.get(
//     Uri.parse('http://localhost:8000/regions/$districtId/concelhos/'),
//   );

//   if (response.statusCode == 200) {
// // If the call to the server was successful, parse the JSON
//     return json.decode(response.body);
//   } else {
// // If that call was not successful, throw an error.
//     throw Exception('Failed to load concelhos');
//  }
// }


class RegistoEmpresaPage extends StatefulWidget {
  const RegistoEmpresaPage({Key? key}) : super(key: key);

  @override
  _RegistoEmpresaPageState createState() => _RegistoEmpresaPageState();
}

class _RegistoEmpresaPageState extends State<RegistoEmpresaPage> {
  final _formKey = GlobalKey<FormState>();


  final List<String>_distritos = [
    'Aveiro', 'Beja', 'Braga', 'Bragança', 'Castelo Branco', 'Coimbra', 'Évora', 'Faro', 'Guarda', 'Leiria', 'Lisboa', 'Portalegre', 'Porto', 'Santarém',
    'Setúbal', 'Viana do Castelo', 'Vila Real', 'Viseu', 'Açores', 'Madeira'];

  final Map<String, List<String>>_concelhosPorDistrito = {
    'Aveiro': [ "Águeda", "Albergaria-a-Velha", "Anadia", "Arouca", "Aveiro", "Castelo de Paiva", "Espinho", "Estarreja", "Ílhavo", "Mealhada", "Murtosa",
      "Oliveira de Azeméis", "Oliveira do Bairro", "Ovar", "Santa Maria da Feira", "São João da Madeira", "Sever do Vouga", "Vagos", "Vale de Cambra"],

    'Beja': [   "Aljustrel", "Almodôvar", "Alvito", "Barrancos", "Beja", "Castro Verde", "Cuba", "Ferreira do Alentejo", "Mértola", "Moura", "Odemira",
      "Ourique", "Serpa", "Vidigueira"],

    'Braga': [  "Amares", "Barcelos", "Braga", "Cabeceiras de Basto", "Celorico de Basto", "Esposende", "Fafe", "Guimarães", "Póvoa de Lanhoso", "Terras de Bouro",
      "Vieira do Minho", "Vila Nova de Famalicão", "Vila Verde", "Vizela"],

    'Bragança':[  "Alfândega da Fé", "Bragança", "Carrazeda de Ansiães", "Freixo de Espada à Cinta", "Macedo de Cavaleiros", "Miranda do Douro", "Mirandela", "Mogadouro",
      "Torre de Moncorvo", "Vila Flor", "Vimioso", "Vinhais"],

    'Castelo Branco': [ "Belmonte", "Castelo Branco", "Covilhã", "Fundão", "Idanha-a-Nova","Oleiros", "Penamacor", "Proença-a-Nova", "Sertã", "Vila de Rei",
      "Vila Velha de Ródão"],

    'Coimbra':[ "Arganil", "Cantanhede", "Coimbra", "Condeixa-a-Nova", "Figueira da Foz", "Góis", "Lousã", "Mealhada", "Mira", "Miranda do Corvo",
      "Montemor-o-Velho", "Oliveira do Hospital", "Pampilhosa da Serra", "Penacova", "Penela", "Soure", "Tábua", "Vila Nova de Poiares"],

    'Évora': [  "Alandroal", "Arraiolos", "Borba", "Estremoz", "Évora", "Montemor-o-Novo", "Mora", "Mourão", "Portel", "Redondo", "Reguengos de Monsaraz",
      "Vendas Novas", "Viana do Alentejo", "Vila Viçosa"],

    'Faro': [ "Albufeira", "Alcoutim", "Aljezur", "Castro Marim", "Faro", "Lagoa", "Lagos", "Loulé", "Monchique", "Olhão", "Portimão", "São Brás de Alportel",
      "Silves", "Tavira", "Vila do Bispo", "Vila Real de Santo António"],

    'Guarda': [ "Aguiar da Beira", "Almeida", "Celorico da Beira", "Figueira de Castelo Rodrigo", "Fornos de Algodres", "Gouveia", "Guarda", "Manteigas",
      "Mêda", "Pinhel","Sabugal", "Seia", "Trancoso", "Vila Nova de Foz Côa"],

    'Leiria': [ "Alcobaça", "Alvaiázere", "Ansião", "Batalha", "Bombarral", "Caldas da Rainha", "Castanheira de Pera", "Figueiró dos Vinhos", "Leiria",
      "Marinha Grande", "Nazaré", "Óbidos", "Pedrógão Grande", "Peniche", "Pombal", "Porto de Mós"],

    'Lisboa': [ "Alenquer", "Amadora", "Arruda dos Vinhos", "Azambuja", "Cadaval", "Cascais", "Lisboa", "Loures", "Lourinhã", "Mafra", "Odivelas",
      "Oeiras", "Sintra", "Sobral de Monte Agraço", "Torres Vedras", "Vila Franca de Xira"],

    'Portalegre': [ "Alter do Chão", "Arronches", "Avis", "Campo Maior", "Castelo de Vide", "Crato", "Elvas", "Fronteira", "Gavião", "Marvão", "Monforte",
      "Nisa", "Ponte de Sor", "Portalegre", "Sousel" ],

    'Porto': [  "Amarante", "Baião", "Felgueiras", "Gondomar", "Lousada", "Maia", "Marco de Canaveses", "Matosinhos", "Paços de Ferreira", "Paredes",
      "Penafiel", "Porto", "Póvoa de Varzim", "Santo Tirso", "Valongo", "Vila do Conde", "Vila Nova de Gaia"],

    'Santarém': [ "Abrantes", "Alcanena", "Almeirim", "Alpiarça", "Benavente", "Cartaxo", "Chamusca", "Constância", "Coruche", "Entroncamento", "Ferreira do Zêzere",
      "Golegã", "Mação", "Rio Maior", "Salvaterra de Magos", "Santarém", "Sardoal", "Tomar", "Torres Novas", "Vila Nova da Barquinha" ],

    'Setúbal': [  "Alcácer do Sal", "Alcochete", "Almada", "Barreiro", "Grândola", "Moita", "Montijo", "Palmela", "Santiago do Cacém", "Seixal", "Sesimbra", "Setúbal", "Sines" ],

    'Viana do Castelo': [ "Arcos de Valdevez", "Caminha", "Melgaço", "Monção", "Paredes de Coura", "Ponte da Barca", "Ponte de Lima", "Valença", "Viana do Castelo",
      "Vila Nova de Cerveira" ],

    'Vila Real': [  "Alijó", "Boticas", "Chaves", "Mesão Frio", "Mondim de Basto", "Montalegre", "Murça", "Peso da Régua", "Ribeira de Pena",
      "Sabrosa", "Santa Marta de Penaguião", "Valpaços", "Vila Pouca de Aguiar", "Vila Real"],

    'Viseu': ["Armamar", "Carregal do Sal", "Castro Daire", "Cinfães", "Lamego", "Mangualde", "Moimenta da Beira", "Mortágua", "Nelas", "Oliveira de Frades",
      "Penalva do Castelo", "Penedono", "Resende", "Santa Comba Dão", "São João da Pesqueira", "São Pedro do Sul", "Sátão", "Sernancelhe", "Tabuaço",
      "Tarouca", "Tondela", "Vila Nova de Paiva", "Viseu", "Vouzela"],

    'Açores': [ "Angra do Heroísmo", "Calheta (São Jorge)", "Corvo", "Horta", "Lagoa (São Miguel)", "Lajes das Flores", "Lajes do Pico", "Madalena", "Nordeste",
      "Ponta Delgada", "Povoação", "Praia da Vitória", "Ribeira Grande", "Santa Cruz da Graciosa", "Santa Cruz das Flores", "São Roque do Pico",
      "Velas", "Vila do Corvo", "Vila Franca do Campo", "Vila do Porto" ],

    'Madeira': ["Calheta (Madeira)", "Câmara de Lobos", "Funchal", "Machico", "Ponta do Sol", "Porto Moniz", "Porto Santo", "Ribeira Brava", "Santa Cruz",
      "Santana", "São Vicente" ]
  };

  final List<String> _servicos = ['Alojamento', 'Transporte', 'Hotelaria', 'Restauração'];

  final Map<String, List<String>> _servicosdisponveis = {'Alojamento': ['AirBnB', 'Alojamento Local'],
    'Transporte': ['Bicicleta', 'Moliceiro', 'Trotinete'],
    'Hotelaria': ['Hotel', 'Hostal'],
    'Restauração': ['Café', 'Restaurante', 'Tasca', 'Snack-Bar']};

  Empresa _empresa = Empresa();
  //List<String> selectedConcelhos =[];
  List<String> selectedServico =[];

  //Future<List<String>> concelhos = getConcelhos("Aveiro");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registo de Empresa'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome da Empresa'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Por favor, insira o nome da empresa.';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    _empresa.nome = value!;
                  },
                ),

                TextFormField(
                  decoration: InputDecoration(labelText: 'Morada'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Por favor, insira a morada da empresa.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _empresa.morada = value!;
                  },
                ),

                TextFormField(
                  decoration: InputDecoration(labelText: 'NIF'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Por favor, insira o NIF da empresa.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _empresa.nif = value!;
                  },
                ),

                TextFormField(
                  decoration: InputDecoration(labelText: 'CAE'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Por favor, insira o CAE da empresa.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _empresa.cae = value!;
                  },
                ),

                TextFormField(
                  decoration:
                  InputDecoration(labelText: 'Contacto telefónico'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Por favor, insira o contacto telefónico da empresa.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _empresa.contacto = value!;
                  },
                ),

                TextFormField(
                  decoration: InputDecoration(labelText: 'E-mail'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, insira o e-mail da empresa.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _empresa.email = value!;
                  },
                ),
                SizedBox(height: 16),

                Text('Região da Atividade'),

                Column(
                  children: _distritos
                      .map(
                        (distrito) => Row(
                      children: <Widget>[
                        Checkbox(
                          value: _empresa.distritos.contains(distrito),
                          onChanged: (value) {
                            setState(() {
                              if (value!) {
                                _empresa.distritos.add(distrito);
                              } else {
                                _empresa.distritos.remove(distrito);
                              }
                            });
                          },
                        ),
                        Text(distrito),
                        if (_empresa.distritos.contains(distrito))
                          Expanded(
                            child: DropdownButton<String>(
                              value: _empresa.concelhos[distrito],
                              onChanged: (String? value) {
                                setState(() {
                                  _empresa.concelhos[distrito] = value!;
                                });
                              },
                              items: _concelhosPorDistrito[distrito]
                                  ?.map(
                                    (cidade) => DropdownMenuItem<String>(
                                  value: cidade,
                                  child: Text(cidade),
                                ),
                              )
                                  .toList(),
                            ),
                          ),
                      ],
                    ),
                  )
                      .toList(),
                ),


                /*  Text('Região da Atividade'),

                Column(
                  children: _distritos
                      .map(
                        (distrito) => Row(
                      children: <Widget>[
                        Checkbox(
                          value: _empresa.distritos.contains(distrito),
                          onChanged: (value) {
                            setState(() {

                              if (value!) {
                                _empresa.distritos.add(distrito);
                              } else {
                                _empresa.distritos.remove(distrito);
                              }
                            });
                          },
                        ),
                        Text(distrito),
                        if (_empresa.distritos.contains(distrito))
                          Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Concelhos:"),
                            Column(
                              children: _distritos.map((_concelhosPorDistrito) {
                                return Checkbox(
                                  value: selectedConcelhos.contains(_concelhosPorDistrito),
                                  onChanged: (value) {
                                    setState(() {
                                      Text(_concelhosPorDistrito);
                                      if (value!) {
                                        selectedConcelhos.add(_concelhosPorDistrito);
                                      } else {
                                        selectedConcelhos.remove(_concelhosPorDistrito);
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                    ],
                    ),
                  )
                      .toList(),
                ), */

                TextFormField(
                  decoration: InputDecoration(labelText: 'Website da empresa'),
                  onSaved: (value) {
                    _empresa.website = value!;
                  },
                ),

                Column(
                  children: _servicos
                      .map(
                        (servico) => Row(
                      children: <Widget>[
                        Checkbox(
                          value: _empresa.servicos.contains(servico),
                          onChanged: (value) {
                            setState(() {
                              if (value!) {
                                _empresa.servicos.add(servico);
                              } else {
                                _empresa.servicos.remove(servico);
                              }
                            });
                          },
                        ),
                        Text(servico),
                        if (_empresa.servicos.contains(servico))
                          Expanded(
                            child: DropdownButton<String>(
                              //value: selectedServico.contains(_servicosdisponveis),
                              onChanged: (String? value) {
                                setState(() {
                                  _empresa.servicoconcreto[servico] = value! as List<String>;
                                });
                              },
                              items: _servicosdisponveis[servico]
                                  ?.map(
                                    (service) => DropdownMenuItem<String>(
                                  value: service,
                                  child: Text(service),
                                ),
                              )
                                  .toList(),
                            ),
                          ),
                      ],
                    ),
                  )
                      .toList(),
                ),

                SizedBox(height: 16),

                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Registar Empresa'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    print(_empresa);

    // Convert the _empresa object to a JSON string
    String empresaJson = jsonEncode(_empresa);
    
    // Send the JSON string to the Django back-end
    final response = await http.post(Uri.parse('http://localhost:8000/empresa'),
    body: jsonEncode(_empresa.toDict()),
    headers: {'Content-Type': 'application/json'});
    
    // Handle the response from the Django back-end
    if (response.statusCode == 200) {
      print('Empresa object sent successfully');
    } else {
      print('Failed to send Empresa object');
    }
  }
}
}

class Empresa {
  late String nome;
  late String morada;
  late String nif;
  late String cae;
  late String contacto;
  late String email;
  List<String> distritos = [];
  Map<String, String> concelhos = {};
  late String website;
  List<String> servicos = [];
  Map<String, List<String>> servicoconcreto = {};

  Map<String, dynamic> toDict() {
    return {
      'nome': nome,
      'morada': morada,
      'nif': nif,
      'cae': cae,
      'contacto': contacto,
      'email': email,
      'distritos': distritos,
      'concelhos': concelhos,
      'website': website,
      'servicos': servicos,
      'servicoconcreto': servicoconcreto,
    };
  }

  String toJson() => jsonEncode(toDict());

  static Empresa fromJson(String source) => fromMap(json.decode(source));

  static Empresa fromMap(Map<String, dynamic> map) {
    return Empresa()
      ..nome = map['nome']
      ..morada = map['morada']
      ..nif = map['nif']
      ..cae = map['cae']
      ..contacto = map['contacto']
      ..email = map['email']
      ..distritos = List<String>.from(map['distritos'])
      ..concelhos = Map<String, String>.from(map['concelhos'])
      ..website = map['website']
      ..servicos = List<String>.from(map['servicos'])
      ..servicoconcreto = Map<String, List<String>>.from(map['servicoconcreto']);
  }

  Map<String, dynamic> get empresa {
    return {
      'nome': nome,
      'morada': morada,
      'nif': nif,
      'cae': cae,
      'contacto': contacto,
      'email': email,
      'distritos': distritos,
      'concelhos': concelhos,
      'website': website,
      'servicos': servicos,
      'servicoconcreto': servicoconcreto,
    };
  }

  @override
  String toString() {
    return 'Empresa(nome: $nome, morada: $morada, nif: $nif, cae: $cae, '
        'contacto: $contacto, email: $email, distritos: $distritos, '
        'concelhos: $concelhos, website: $website servicos: $servicos, '
        'servicoconcreto: $servicoconcreto)';
  }
}