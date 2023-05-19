import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final double width;
  final double height;

  CardWidget({
    required this.title,
    required this.subtitle,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
            ),
          ],
        ),
      ),
    );
  }
}





