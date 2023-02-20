import 'package:flutter/material.dart';
import 'constants.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle ({
    Key key,
    this.title,
    this.subtitle,
    this.color,
  }) : super(key: key);

  final String title, subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
      constraints: BoxConstraints(maxWidth: 1110),
      height: 100,
      child: Row(
        children: [
          Container(
            
          ),
        ],
      ),
    );
  }
}

