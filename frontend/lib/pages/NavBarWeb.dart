import 'package:flutter/cupertino.dart';

class NavigationBarWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: const [
          Text(
            'MainPage',
                style:TextStyle(fontSize: 20.0),
          ),

          SizedBox(width: 100.0),

          Text(
            'Sobre',
            style:TextStyle(fontSize: 20.0),
          ),

          SizedBox(width: 100.0),

          Text(
            '...',
            style:TextStyle(fontSize: 20.0),
          ),

        ],
      ),
    );
  }
}