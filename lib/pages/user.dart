import 'package:antas_test/pages/index.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {

  final User userItem;
  UserPage(this.userItem);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.4,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(userItem.url),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.6,
            child: Container(
              color: Colors.white,
            ),
          ),
        ]
      )
      
    );
  }
}