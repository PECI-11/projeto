import 'package:flutter/material.dart';

class RegistoEmpresaPage extends StatefulWidget {
  @override
  _RegistoEmpresaPageState createState() => _RegistoEmpresaPageState();
}

class _RegistoEmpresaPageState extends State<RegistoEmpresaPage> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _regioes = [
    'Região Norte',
    'Região Centro',
    'Região Sul',
    'Açores',
    'Madeira'
  ];

  final Map<String, List<String>> _cidadesPorRegiao = {
    'Região Norte': ['Braga', 'Porto', 'Viana do Castelo', 'Vila Real'],
    'Região Centro': [
      'Aveiro',
      'Castelo Branco',
      'Coimbra',
      'Guarda',
      'Leiria',
      'Santarém',
      'Viseu'
    ],
    'Região Sul': [
      'Beja',
      'Faro',
      'Lisboa',
      'Portalegre',
      'Setúbal',
      'Évora'
    ],
    'Açores': [
      'Angra do Heroísmo',
      'Horta',
      'Ponta Delgada',
      'Santa Cruz da Graciosa',
      'Santa Cruz das Flores',
      'São Roque do Pico',
      'Velas'
    ],
    'Madeira': ['Funchal', 'Machico', 'Ponta do Sol', 'Porto Moniz']
  };

  var _empresa = Empresa();

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
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome da Empresa'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor, insira o nome da empresa.';
                    }
                    return null;
                  },
                  onSaved: (value) => _empresa.nome = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Morada'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor, insira a morada da empresa.';
                    }
                    return null;
                  },
                  onSaved: (value) => _empresa.morada = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'NIF'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor, insira o NIF da empresa.';
                    }
                    return null;
                  },
                  onSaved: (value) => _empresa.nif = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'CAE'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor, insira o CAE da empresa.';
                    }
                    return null;
                  },
                  onSaved: (value) => _empresa.cae = value,
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Contacto telefónico'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor, insira o contacto telefónico da empresa.';
                    }
                    return null;
                  },
                  onSaved: (value) => _empresa.contacto = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-mail'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor, insira o e-mail da empresa.';
                    }
                    return null;
                  },
                  onSaved: (value) => _empresa.email = value,
                ),
                SizedBox(height: 16),
                Text('Região da Atividade'),
                Column(
                  children: _regioes
                      .map(
                        (regiao) => Row(
                          children: <Widget>[
                            Checkbox(
                              value: _empresa.regioes.contains(regiao),
                              onChanged: (value) {
                                setState(() {
                                  if (value) {
                                    _empresa.regioes.add(regiao);
                                  } else {
                                    _empresa.regioes.remove(regiao);
                                  }
                                });
                              },
                            ),
                            Text(regiao),
                            if (_empresa.regioes.contains(regiao))
                              Expanded(
                                child: DropdownButton<String>(
                                  value: _empresa.cidades[regiao],
                                  onChanged: (value) {
                                    setState(() {
                                      _empresa.cidades[regiao] = value;
                                    });
                                  },
                                  items: _cidadesPorRegiao[regiao]
                                      .map(
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
                TextFormField(
                  decoration: InputDecoration(labelText: 'Website da empresa'),
                  onSaved: (value) => _empresa.website = value,
                ),
                SizedBox(height: 16),
                RaisedButton(
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

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_empresa);
      // Salvar os dados no banco de dados ou em outro local de armazenamento.
    }
  }
}

class Empresa {
  String nome;
  String morada;
  String nif;
  String cae;
  String contacto;
  String email;
  List<String> regioes = [];
  Map<String, String> cidades = {};
  String website;

  @override
  String toString() {
    return 'Empresa(nome: $nome, morada: $morada, nif: $nif, cae: $cae, '
        'contacto: $contacto, email: $email, regioes: $regioes, '
        'cidades: $cidades, website: $website)';
  }
}

