import 'dart:convert';

import '../registo_empresas/registo.dart';

class Users {
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
  Map<String, String> servicoconcreto = {};

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
      ..servicoconcreto = Map<String, String>.from(map['servicoconcreto']);
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