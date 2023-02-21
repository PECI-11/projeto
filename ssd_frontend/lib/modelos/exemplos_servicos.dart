import 'package:flutter/material.dart';

class Servico {
  final int id;
  final String title, image;
  final Color color;

  Servico(this.id, this.title, this.image, this.color);
}

// Demo list de serviços
List<Servico> servicos = [
  Servico(
      id: 1,
      title:"Hotelaria",
      image: "assets/servicos_icons/hotel-png.png",
      color: Color(0xFFD9FFFC),
  ),

  Servico(
    id: 1,
    title:"Restauração",
    image: "assets/servicos_icons/restaurante.png",
    color: Color(0xFFD9FFFC),
  ),

  Servico(
    id: 1,
    title:"Bar de Praia",
    image: "assets/servicos_icons/beach-bar.png",
    color: Color(0xFFD9FFFC),
  ),
];



